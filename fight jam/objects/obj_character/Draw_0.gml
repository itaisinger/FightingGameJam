if(disable_draw) 
	exit;

draw_reset();

//if(is_color_inverted)
//	shader_set(sh_invert)

image_xscale = dir*scalex;
image_yscale = scaley;
if(is_echo) image_alpha = ECHO_ALPHA;

//shadow
var _shadow_w = image_xscale * map_value(abs(y-floor_y),0,400,1,1.5) * shadow_w;
var _shadow_a = map_value(200-abs(y-floor_y),0,400,0.1,0.2);
draw_sprite_ext(spr_fighter_shadow,0,x,floor_y,_shadow_w,image_yscale,0,c_white,_shadow_a);


/// SHADER
shader_set(sh_outline);
var tex_w = texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
var tex_h = texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
shader_set_uniform_f(u_texel, tex_w, tex_h);
shader_set_uniform_f(u_outline_col, outline_col[0], outline_col[1], outline_col[2], 0.5); 
shader_set_uniform_f(u_thickness, 2.0);

//sur
var _m = 5;
var _sur_w = abs(sprite_width) + 2 * _m
var _sur_h = abs(sprite_height) + 2 * _m
var _sur = surface_create(_sur_w,_sur_h)
surface_set_target(_sur);

// shake
var _shake_mult = 2;
if(current_time%3 == 0){
	var _active = state == STATES.stun or state == STATES.air_stun;
	_yshake = clamp(_active*_shake_mult*random_range(-hitpause_remain,hitpause_remain),-shake_max,shake_max)
	_xshake = clamp(_active*_shake_mult*random_range(-hitpause_remain,hitpause_remain),-shake_max,shake_max);
}
x += _xshake;
y += _yshake;

//draw_self();
draw_sprite(sprite_index,image_index,abs(sprite_width)/2 + _m, abs(sprite_height) + _m);
surface_reset_target();
draw_surface_ext(_sur,x - _sur_w/2,y - (_sur_h-_m),image_xscale,image_yscale,image_angle,image_blend,image_alpha);

x -= _xshake;
y -= _yshake;

draw_set_alpha(1);

// afterimage
if(afterimage_remain>0 and current_time%afterimage_diff == 0){
	afterimage_remain--;
	with(instance_create_depth(x,y,depth+1,obj_afterimage)){
		image_speed = 0;
		sprite_index = other.sprite_index;
		image_index = other.image_index;
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
		is_color_inverted = other.is_color_inverted;
	}
}

//if(is_color_inverted)
	//shader_reset();

surface_free(_sur);
shader_reset();
