function approach(val,spd,dest){
	if(val == dest) return dest;
	
	if (val > dest) return max(val-spd,dest);
	if (val < dest) return min(val+spd,dest);
}
function draw_set_all(alpha=1,color=c_white,font=font_main,halign=fa_left,valign=fa_top)
{
	draw_set_alpha(alpha);
	draw_set_color(color);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(font);
}
function draw_reset()
{
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
function log(msg)
{
	show_debug_message(object_get_name(object_index) + ": " + string(msg));
}
function play_sfx(_sfx,_prio,_loop,_pitch,_gain)
{	
	var _l = is_undefined(_loop)  ? 0 : _loop;	//loop
	var _p = is_undefined(_prio)  ? 0 : _prio;	//priority
	var _t = is_undefined(_pitch) ? 1 : _pitch;	//pitch
	var _g = is_undefined(_gain)  ? 1 : _gain;	//gain
	
	//pitch array
	if(is_array(_t))
	{
		_t = random_range(_t[0],_t[1]);
	}
	
	//play
	var _o_gain = audio_sound_get_gain(_sfx);
	var _s = audio_play_sound(_sfx,_p,_l);
	audio_sound_gain(_s,_o_gain*global.sfx_volume*_g,0);	
	audio_sound_pitch(_s,_t);
	
	return _s;
}
global.sfx_volume = 1;

function create_vfx(_x,_y,_scale,asset,_angle=0){
	return instance_create_depth(_x,_y,DEPTH.vfx,obj_vfx,{sprite_index: asset, image_xscale: _scale, image_yscale: _scale, image_angle: _angle});
}
function map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound) {
    return (((_value - _current_lower_bound) / (_current_upper_bound - _current_lower_bound)) * (_desired_upper_bound - _desired_lowered_bound)) + _desired_lowered_bound;
}
function wave(from, to, duration, offset=0)
{
	// Returns a value that will wave back and forth between [from-to] over [duration] seconds
	// Examples
	//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
	//      x = Wave(-10,10,0.25,0)         -> move left and right quickly
 
	// Or here is a fun one! Make an object be all squishy!! ^u^
	//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
	//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
 
	a4 = (argument1 - argument0) * 0.5;
	return argument0 + a4 + sin((((current_time * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;
}