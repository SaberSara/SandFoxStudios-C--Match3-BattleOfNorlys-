// Pixel shader applies a one dimensional gaussian blur filter.
// This is used twice by the bloom postprocess, first to
// blur horizontally, and then again to blur vertically.

#include "fragmentshaderbase.fxh"

#ifndef GSE_CG
sampler2D TextureSampler = sampler_state {
    Texture = (gDiffuseTexture);
};
#else
sampler2D TextureSampler : SOURCE;
#endif

#define SAMPLE_COUNT 15

float2 SampleOffsets[SAMPLE_COUNT];
float SampleWeights[SAMPLE_COUNT];


float4 PixelShaderFunction(float2 texCoord : TEXCOORD0) : COLOR0
{
    float4 c = 0;
    
    // Combine a number of weighted image filter taps.
    for (int i = 0; i < SAMPLE_COUNT; i++)
    {
        c += tex2D(TextureSampler, texCoord + SampleOffsets[i]) * SampleWeights[i];
    }
    
    return c;
}


technique GaussianBlur
{
    pass Pass1
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
