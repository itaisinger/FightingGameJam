varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel;       // texel size: (1/tex_width, 1/tex_height)
uniform vec4 u_outline_col; // outline color (r, g, b, a)
uniform float u_thickness;  // outline thickness in pixels

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);

    // Sample 4 neighbors
    float up    = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0,  u_thickness) * u_texel).a;
    float down  = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -u_thickness) * u_texel).a;
    float left  = texture2D(gm_BaseTexture, v_vTexcoord + vec2(-u_thickness, 0.0) * u_texel).a;
    float right = texture2D(gm_BaseTexture, v_vTexcoord + vec2( u_thickness, 0.0) * u_texel).a;

    float neighbor_max = max(max(up, down), max(left, right));

    // Draw outline if this pixel is transparent but a neighbor isn't
    if (base.a < 0.01 && neighbor_max > 0.1) {
        gl_FragColor = u_outline_col;
    } else {
        gl_FragColor = base * v_vColour;
    }
}