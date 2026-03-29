if(disable_draw) 
	exit;

draw_reset();

//shadow
draw_sprite_ext(spr_fighter_shadow,0,x,floor_y,image_xscale,image_yscale,0,c_white,0.2);

image_xscale = dir;
if(is_echo) image_alpha = ECHO_ALPHA;

// shake
var _shake_mult = 2;
if(current_time%3 == 0){
	var _active = state == STATES.stun or state == STATES.air_stun;
	_yshake = clamp(_active*_shake_mult*random_range(-hitpause_remain,hitpause_remain),-shake_max,shake_max)
	_xshake = clamp(_active*_shake_mult*random_range(-hitpause_remain,hitpause_remain),-shake_max,shake_max);
}
x += _xshake;
y += _yshake;

draw_self();

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
	}
}