var _w = room_width;
var _h = room_height;
var _player_off = _w * 0.2;
var _binds = global.keybinds;
draw_set_all(1,c_white,font_binds,fa_center,fa_top)
var _newline = string_height("G") * 1.1;
var yy = _h * 0.2;

//draw inputs
for(var i=0; i < array_length(_binds); i++)
{
	var _bind = _binds[i];
	if(!is_array(_bind) or array_length(_bind) < 3)
		continue
		
	draw_set_halign(fa_center);
	draw_text(_w/2,yy,_bind[2]);
	
	yy += _newline;
}