/// @description Insert description here
// You can write your code in this editor
var _w = camera_get_view_width(view_camera);
var _h = camera_get_view_height(view_camera);

var _y = _h * 0.1;
var _s = 2;

//vs
draw_sprite_ext(spr_vs,0,_w/2,_y,_s,_s,0,c_white,1);

#region hp

_s = 4;
var _sprite_w = sprite_get_width(spr_hp)
var _hp_margin = 60;

//p2
var _p = arr_players[1];
draw_sprite_ext(spr_hp,1,_w/2 + _hp_margin,_y,-_s,_s,0,c_white,1);

var _hp_prec = _p.hp / _p.max_hp;

draw_sprite_part_ext(spr_hp,0,  _sprite_w - _hp_prec * _sprite_w,0, _hp_prec * _sprite_w,sprite_get_height(spr_hp) ,_w/2 + _hp_margin + _s*_sprite_w - (1-_hp_prec)*_sprite_w*_s,_y,-_s,_s,c_white,1);
//draw_sprite_part_ext(spr_hp,0, 0,0, _hp_prec * _sprite_w,sprite_get_height(spr_hp) ,_w/2 + _hp_margin + _s*_sprite_w,_y,-_s,_s,c_white,1);


//p1
var _p = arr_players[0];
draw_sprite_ext(spr_hp,1,_w/2 - _hp_margin,_y,_s,_s,0,c_white,1);

var _hp_prec = _p.hp / _p.max_hp;

draw_sprite_part_ext(spr_hp,0, _sprite_w - _hp_prec * _sprite_w,0, _hp_prec * _sprite_w,sprite_get_height(spr_hp),_w/2 - _hp_margin - _sprite_w*_s + (1-_hp_prec)*_s*_sprite_w,_y,_s,_s,c_white,1);

#endregion