var _w = room_width;
var _h = room_height;
var _player_off = _w * 0.2;
var _binds = global.keybinds;
draw_set_all(1,c_white,font_binds,fa_center,fa_top)
var _newline = string_height("G") * 1.1;
var yy = _h * 0.3;
var _col2 = c_orange;

//draw inputs
var b = 0;
for(var i=0; i < INPUT.max; i++)
{
	var _bind = _binds[i];
	//if(!is_array(_bind) or array_length(_bind) < 3)
	//	continue
	
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(_w/2,yy,_bind[2]);
	
	//p1
	draw_set_halign(fa_left);
	draw_set_color(is_choosing[0] ? _col2 : c_white);
	draw_text(_w*0.2,yy + select_yoff[0] * (index[0] == b),get_key_name(_bind[0]));
	
	//p2
	draw_set_halign(fa_right);
	draw_set_color(is_choosing[1] ? _col2 : c_white);
	draw_text(_w*0.8,yy + select_yoff[1] * (index[1] == b),get_key_name(_bind[1]));
	
	yy += _newline;
	b++;
}