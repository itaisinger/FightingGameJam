var _c1 = c_black
var _c2 = #9E0B0F
draw_rectangle_colour(0,0,room_width,room_height*2,_c1,_c1,_c2,_c2,0);

var _w = room_width;
var _h = room_height;
var _player_off = _w * 0.2;
var _binds = global.user_keybinds;
draw_set_all(1,c_white,font_binds,fa_center,fa_top)
var _newline = string_height("G") * 1.1;
var yy = _h * 0.3;
var _c_hover = c_orange;
var _c_select = c_red;

//title
draw_text(_w/2,_h*0.15,"choose with light attack, reset with heavy, go back with Escape");

//loop inputs
for(var i=0; i < INPUT.max; i++)
{
	var _bind = _binds[i];
	
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(_w/2,yy,_bind[2]);
	
	//loop players
	for(var p=0; p < 2; p++){
		draw_set_halign(p == 0 ? fa_left : fa_right);
		var _col = c_white;
		if(index == i and is_p1 == p) _col = is_choosing ? _c_select : _c_hover
		draw_set_color(_col);
		draw_text(_w*(0.2 + 0.6*p), yy + select_yoff * (index == i and is_p1 == p),get_key_name(_bind[p]));
	}
	
	yy += _newline;
}