//
//	brightens the image
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float brightness;

void main()
{
	vec4 tex_color = texture2D(gm_BaseTexture, v_vTexcoord);
	tex_color.rgb = mix(tex_color.rgb, vec3(1.0), brightness);
    gl_FragColor = tex_color;
}