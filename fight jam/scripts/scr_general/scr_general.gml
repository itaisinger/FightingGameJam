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
	try{show_debug_message(object_get_name(object_index) + ": " + string(msg));}
	catch(e){show_debug_message("no object: " + string(msg));}
}
function play_sfx(_sfx,_prio=0,_loop=0,_pitch=1,_gain=1)
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
	var _s = VinylPlay(_sfx,_l,_o_gain*global.sfx_volume*_g,_t);
	//audio_sound_gain(_s,_o_gain*global.sfx_volume*_g,0);	
	//audio_sound_pitch(_s,_t);
	
	return _s;
}
function stop_sfx(sfx_inst,fade_out_seconds=0)
{
	if(fade_out_seconds == 0)
		VinylStop(sfx_inst);
	else
		VinylFadeOut(sfx_inst,1/fade_out_seconds)
}
function array_random(array)
{
	return array[irandom(array_length(array)-1)];
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
 
	a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4;
}

function room_trans(rm)
{
	if(!instance_exists(obj_transition)) instance_create_depth(0,0,0,obj_transition);
	
	with(obj_transition) if (state == TRANS_STATES.off)
	{
		target = rm;
		state = TRANS_STATES.in;
		trans_prec = 0;	//double check
	}
}
function string_pad(str_left, str_right, L) {
    var combined_len = string_length(str_left) + string_length(str_right);
    var spaces = L - combined_len;
    var padding = "";
    repeat (spaces) {
        padding += " ";
    }
    return str_left + padding + str_right;
}
	
