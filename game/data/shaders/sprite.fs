//
// sprite.fs
//
// original code : Malek Bengougam
//
// (c) Rewind Engine 2010, All rights reserved.
//

uniform sampler2D u_diffuseTexture;

varying vec4 v_color;
varying vec4 v_texCoords0;

void main(void)
{
	gl_FragColor = v_color * texture2D(u_diffuseTexture, v_texCoords0.st);
}
