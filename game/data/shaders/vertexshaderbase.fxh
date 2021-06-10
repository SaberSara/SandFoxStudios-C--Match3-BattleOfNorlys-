//
// base vertex shader include  
//
// original code : Malek Bengougam
//
// (c) Rewind Engine 2010, All rights reserved.
//

// ___ globals ________________________________________________________________

#ifdef GSE_CG
#define gseMul(a,b) mul(b,a)
#else
#define gseMul(a,b) mul(a,b)
#endif

matrix gTransform : WorldViewProjection;

// ___ classes ________________________________________________________________

struct Vertex
{
	float4 position		: POSITION;
	float4 diffuse		: COLOR;
	float4 texcoords	: TEXCOORD0;
};

// ___ vertex shaders _________________________________________________________

void spriteVS(in const Vertex IN, out Vertex OUT)
{
	OUT.position = gseMul(IN.position, gTransform);
	OUT.diffuse = IN.diffuse;
	OUT.texcoords = IN.texcoords;
};
