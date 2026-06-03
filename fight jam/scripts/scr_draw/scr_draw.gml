function draw_outlined_old(sprite,image,x,y,xscale,yscale,angle,alpha,color_arr)
{
	//draw_self();
	//return;
	if(live_call()) return live_result;
	
	static u_texel       = shader_get_uniform(sh_outline, "u_texel");
	static u_outline_col = shader_get_uniform(sh_outline, "u_outline_col");
	static u_thickness   = shader_get_uniform(sh_outline, "u_thickness");
	
	var _m = 2.0
	var _sur_w = _m*2 + abs(xscale) * sprite_get_width(sprite);
	var _sur_h = _m*2 + abs(yscale) * sprite_get_height(sprite);
	var _sur = surface_create(_sur_w,_sur_h);
	surface_set_target(_sur);
	draw_clear_alpha(c_white,0)

	shader_set(sh_outline);
	var tex_w = texture_get_texel_width(sprite_get_texture(sprite,image))
	var tex_h = texture_get_texel_height(sprite_get_texture(sprite,image))
	shader_set_uniform_f(u_texel, tex_w, tex_h);
	shader_set_uniform_f(u_outline_col, color_arr[0], color_arr[1], color_arr[2], OUTLINE_ALPHA); 
	shader_set_uniform_f(u_thickness, _m);
	
	//draw_rectangle(0,0, _sur_w, _sur_h,0)
	//draw_sprite_part_ext(sprite,image,0,0,sprite_get_width(sprite),sprite_get_height(sprite), _m,_m, xscale,yscale,c_white,alpha*2);
	draw_sprite_ext(sprite,image, _sur_w/2 + _m, _sur_h - _m, xscale,yscale,0,c_white,alpha);
	
	surface_reset_target();
	draw_surface(_sur,x - (_sur_w/2 + _m),y - _sur_h + _m)
	//draw_surface(_sur,x - sprite_get_xoffset(sprite)*xscale,y - sprite_get_yoffset(sprite)*yscale)
	
	shader_reset();
	surface_free(_sur);
}
function draw_colored(sprite,image,x,y,xscale,yscale,angle,alpha,color_arr)
{	
	var _col = merge_colour(c_white,make_colour_rgb(255*color_arr[0],255*color_arr[1],255*color_arr[2]),0.5)
	draw_sprite_ext(sprite,image,x,y,xscale,yscale,0,_col,alpha);
}
function draw_outlined(sprite,image,x,y,xscale,yscale,angle,alpha,color_arr)
{
	var _m = 2.0
	var _sur_w = _m*2 + abs(xscale) * sprite_get_width(sprite);
	var _sur_h = _m*2 + abs(yscale) * sprite_get_height(sprite);
	var _sur = surface_create(_sur_w,_sur_h);
	surface_set_target(_sur);
	draw_clear_alpha(c_white,0)

	shader_set(sh_sillouete);
	
	var _x =  _sur_w/2 + _m;
	var _y = _sur_h - _m;
	
	//outline
	draw_sprite_ext(sprite,image,_x-_m,_y, xscale,yscale,0,c_white,1);
	draw_sprite_ext(sprite,image,_x+_m,_y, xscale,yscale,0,c_white,1);
	draw_sprite_ext(sprite,image,_x,_y+_m, xscale,yscale,0,c_white,1);
	draw_sprite_ext(sprite,image,_x,_y-_m, xscale,yscale,0,c_white,1);
	surface_reset_target();
	
	//me
	shader_reset();
	//draw_sprite_ext(sprite,image,_x,_y, xscale,yscale,0,c_white,1);
	
	draw_surface_ext(_sur,x - (_sur_w/2 + _m),y - _sur_h + _m,1,1,0,color_arr,OUTLINE_ALPHA)
	draw_self()
	
	surface_free(_sur);
	
}