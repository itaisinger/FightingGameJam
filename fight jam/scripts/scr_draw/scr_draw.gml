function draw_outlined(sprite,image,x,y,xscale,yscale,angle,alpha,color_arr)
{
	static u_texel       = shader_get_uniform(sh_outline, "u_texel");
	static u_outline_col = shader_get_uniform(sh_outline, "u_outline_col");
	static u_thickness   = shader_get_uniform(sh_outline, "u_thickness");
	
	shader_set(sh_outline);
	var tex_w = texture_get_texel_width(sprite_get_texture(sprite,image))
	var tex_h = texture_get_texel_height(sprite_get_texture(sprite,image))
	shader_set_uniform_f(u_texel, tex_w, tex_h);
	shader_set_uniform_f(u_outline_col, color_arr[0], color_arr[1], color_arr[2], OUTLINE_ALPHA); 
	shader_set_uniform_f(u_thickness, 2.0);
	
	draw_sprite_ext(sprite,image,x,y,xscale,yscale,angle,c_white,alpha);
	
	shader_reset();
}
