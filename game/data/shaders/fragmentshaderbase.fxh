//
// base fragment shader include  
//
// original code : Malek Bengougam
//
// (c) Rewind Engine 2010, All rights reserved.
//

// ___ globals ________________________________________________________________

texture gDiffuseTexture : SOURCE;

// ___ classes ________________________________________________________________

#ifndef GDK
#define FRAGMENT_IN float4 color : COLOR, float4 texcoords : TEXCOORD0, float4 customData : TEXCOORD1
#else
#define FRAGMENT_IN float4 color : COLOR, float4 texcoords : TEXCOORD0
float4 customData;
#endif