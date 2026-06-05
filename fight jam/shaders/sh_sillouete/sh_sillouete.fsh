//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if(gl_FragColor.a > 0.05){
		gl_FragColor.rgb = vec3(1.0, 1.0, 1.0);
		//gl_FragColor.rgb = vec3(0.2,0.2,0.2) + gl_FragColor.rgb;
	}
}
