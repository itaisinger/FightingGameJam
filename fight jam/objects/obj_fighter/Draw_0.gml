draw_reset();
image_xscale = dir;
if(is_echo) image_alpha = 0.5;

// shake
var _shake_mult = 2;
if(current_time%3 == 0){
	var _active = state == STATES.stun or state == STATES.air_stun;
	_yshake = _active*_shake_mult*random_range(-hitpause_remain,hitpause_remain)
	_xshake = _active*_shake_mult*random_range(-hitpause_remain,hitpause_remain)
}
x += _xshake;
y += _yshake;

draw_self();

x -= _xshake;
y -= _yshake;

draw_set_alpha(1);