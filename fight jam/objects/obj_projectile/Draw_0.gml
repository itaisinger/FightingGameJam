// shake
var _shake_mult = 2;
if(current_time%3 == 0){
	_yshake = _shake_mult*random_range(-shake_remain,shake_remain)
	_xshake = _shake_mult*random_range(-shake_remain,shake_remain)
}
x += _xshake;
y += _yshake;

draw_self();

x -= _xshake;
y -= _yshake;