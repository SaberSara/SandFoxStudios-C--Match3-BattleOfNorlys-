// Pixel shader combines the bloom image with the original
// scene, using tweakable intensity levels and saturation.
// This is the final step in applying a bloom postprocess.

#include "fragmentshaderbase.fxh"

#ifndef GSE_CG
sampler2D BloomSampler = sampler_state {
    Texture = (gDiffuseTexture);
};
texture gBackgroundTexture : BACKGROUND;
sampler2D BaseSampler = sampler_state {
    Texture = (gBackgroundTexture);
};
#else
sampler2D BloomSampler : SOURCE;
sampler2D BaseSampler : BACKGROUND;
#endif

float BloomIntensity;
float BaseIntensity;

float BloomSaturation;
float BaseSaturation;


// Helper for modifying the saturation of a color.
float4 AdjustSaturation(float4 color, float saturation)
{
    // The constants 0.3, 0.59, and 0.11 are chosen because the
    // human eye is more sensitive to green light, and less to blue.
    float grey = dot(color, float3(0.3, 0.59, 0.11));

    return lerp(grey, color, saturation);
}


float4 PixelShaderFunction(FRAGMENT_IN) : COLOR0
{
    // Look up the bloom and original base image colors.
    float4 bloom = tex2D(BloomSampler, texcoords.xy);
    float4 base = tex2D(BaseSampler, texcoords.zw);
    
    // Adjust color saturation and intensity.
    bloom = AdjustSaturation(bloom, BloomSaturation) * BloomIntensity;
    base = AdjustSaturation(base, BaseSaturation) * BaseIntensity;
    
    // Darken down the base image in areas where there is a lot of bloom,
    // to prevent things looking excessively burned-out.
    base *= (1.0 - saturate(bloom));
    
    // Combine the two images.
    return base + bloom;
}


technique BloomCombine
{
    pass Pass1
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
