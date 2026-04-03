/// @description Insert description here
// You can write your code in this editor

var _w = display_get_gui_width();
var _h = display_get_gui_height();

var _y = _h * 0.08;
var _s = 1;

//vs
draw_sprite_ext(spr_vs,0,_w/2,_y,_s,_s,0,c_white,1);

#region hp


//shake
var _max_s = 3;
if(current_time % 3 == 0) for(var i=0; i < 2; i++){
	hp_shakex[i] = random_range(-min(_max_s,hp_shake_remain[i]),min(_max_s,hp_shake_remain[i]))
	hp_shakey[i] = random_range(-min(_max_s,hp_shake_remain[i]),min(_max_s,hp_shake_remain[i]))
}

_s = 1;
var _sprite_w = sprite_get_width(spr_hp)
var _hp_margin = 20;

//p2
var _p = arr_players[1];
draw_sprite_ext(spr_hp,1,_w/2 + _hp_margin + hp_shakex[1],_y + hp_shakex[1],-_s,_s,0,c_white,1);

var _hp_prec = _p.hp / _p.max_hp;

draw_sprite_part_ext(spr_hp,0,  _sprite_w - _hp_prec * _sprite_w,0, _hp_prec * _sprite_w,sprite_get_height(spr_hp) ,_w/2 + _hp_margin + _s*_sprite_w - (1-_hp_prec)*_sprite_w*_s + hp_shakex[1],_y+ hp_shakey[1],-_s,_s,c_white,1);


//p1
var _p = arr_players[0];
draw_sprite_ext(spr_hp,1,_w/2 - _hp_margin + hp_shakex[0],_y + hp_shakey[0],_s,_s,0,c_white,1);

var _hp_prec = _p.hp / _p.max_hp;

draw_sprite_part_ext(spr_hp,0, _sprite_w - _hp_prec * _sprite_w,0, _hp_prec * _sprite_w,sprite_get_height(spr_hp),_w/2 - _hp_margin - _sprite_w*_s + (1-_hp_prec)*_s*_sprite_w + hp_shakex[0],_y+hp_shakey[0],_s,_s,c_white,1);

#endregion
#region echo charges

var _m = sprite_get_width(spr_echo_charge) + 1;
var _echo_y = _y + 16;

if(current_time % 3 == 0) for(var i=0; i < 2; i++){
	echo_shakex[i][1] = echo_shakex[i][0];
	echo_shakex[i][0] = random_range(-min(_max_s,echo_shake_remain[i]),min(_max_s,echo_shake_remain[i]))
	echo_shakey[i][1] = echo_shakey[i][0];
	echo_shakey[i][0] = random_range(-min(_max_s,echo_shake_remain[i]),min(_max_s,echo_shake_remain[i]))
}

for(var i=0; i < _p.echo_charges_max; i++){

	var _xoff = (1+i)*_m + 7

	//empty
	draw_sprite(spr_echo_charge,0, _w/2 + _xoff + echo_shakex[1][1],_echo_y + echo_shakey[1][1])
	draw_sprite(spr_echo_charge,0, _w/2 - _xoff + echo_shakey[0][1],_echo_y + echo_shakey[0][1])

	//full
	if(arr_players[1].echo_charges_remain > i) draw_sprite(spr_echo_charge,1, _w/2 + _xoff + echo_shakex[1][0],_echo_y + echo_shakey[1][0])
	if(arr_players[0].echo_charges_remain > i) draw_sprite(spr_echo_charge,1, _w/2 - _xoff + echo_shakex[0][0],_echo_y + echo_shakey[0][0])
}

#endregion
#region annoncer

if(announce_text != ""){
	
	if(cd-- <= 0){
		cd = 10
		image++
	}
	
	draw_sprite_ext(spr_announce_spark	,image,_w/2+5,_h/2,1,1,0,c_white,1)
	draw_sprite_ext(spr_announce_spark_2,image,_w/2-5,_h/2,1,1,0,c_white,1)
	
	var _col1 = c_black
	var _col2 = #9E0B0F
	
	var _font = font_announce;
	if(string_length(announce_text) > 7) _font = font_announce_small;
	draw_set_all(1,c_white,_font,fa_center,fa_middle);
	var _text = string_split(announce_text,"\n");
	var _th = string_height("G")*0.6;
	
	for(var i=0; i < array_length(_text); i++)
		draw_text_color(_w/2,_h/2 + i*_th - _th*(array_length(_text)-1)/2,_text[i],_col1,_col1,_col2,_col2,1)
}

#endregion