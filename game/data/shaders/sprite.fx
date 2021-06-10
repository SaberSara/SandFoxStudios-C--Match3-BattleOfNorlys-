//
// Sprite fx  
//
// original code : Malek Bengougam
//
// (c) Rewind Engine 2010, All rights reserved.
//

// ___ includes _______________________________________________________________

#include "fragmentshaderbase.fxh"

#ifndef GSE_CG
sampler2D diffuse = sampler_state {
    Texture = (gDiffuseTexture);
};
#else
sampler2D diffuse : SOURCE;
#endif

// ___ fragment shaders _______________________________________________________

float4 basicFS(float2 texcoords : TEXCOORD0) : COLOR0
{
	return tex2D(diffuse, texcoords);
};

float4 spriteFS(FRAGMENT_IN) : COLOR0
{
	float4 outColor = tex2D(diffuse, texcoords) * color;
	return outColor;
};

// ___ techniques _____________________________________________________________

technique basic
{
    pass p0
    {
        PixelShader = compile ps_2_0 basicFS();
    }
}

technique sprite
{
    pass p0
    {
        PixelShader = compile ps_2_0 spriteFS();
    }
}