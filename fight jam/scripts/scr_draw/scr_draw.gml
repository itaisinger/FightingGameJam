function draw_outlined(sprite,image,x,y,xscale,yscale,angle,alpha,color_arr)
{
	draw_self();
	return;
	if(live_call()) return live_result;
	
	static u_texel       = shader_get_uniform(sh_outline, "u_texel");
	static u_outline_col = shader_get_uniform(sh_outline, "u_outline_col");
	static u_thickness   = shader_get_uniform(sh_outline, "u_thickness");
	
	var _m = 2.0
	var _sur_w = _m*2 + abs(xscale) * sprite_get_width(sprite);
	var _sur_h = _m*2 + abs(yscale) * sprite_get_height(sprite);
	var _sur = surface_create(_sur_w,_sur_h)
	surface_set_target(_sur);
	
	shader_set(sh_outline);
	var tex_w = texture_get_texel_width(sprite_get_texture(sprite,image))
	var tex_h = texture_get_texel_height(sprite_get_texture(sprite,image))
	shader_set_uniform_f(u_texel, tex_w, tex_h);
	shader_set_uniform_f(u_outline_col, color_arr[0], color_arr[1], color_arr[2], OUTLINE_ALPHA); 
	shader_set_uniform_f(u_thickness, _m);
	
	draw_sprite_part_ext(sprite,image,0,0,sprite_get_width(sprite),sprite_get_height(sprite), _m,_m, xscale,yscale,c_white,alpha);
	
	surface_reset_target();
	draw_surface(_sur,x - sprite_get_xoffset(sprite)*xscale,y - sprite_get_yoffset(sprite)*yscale)
	
	shader_reset();
	surface_free(_sur);
}
