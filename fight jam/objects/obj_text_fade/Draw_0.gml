var _cur = animcurve_get(cur_text_fade);
var _ch = animcurve_get_channel(_cur,"alpha");
var _a = animcurve_channel_evaluate(_ch,prec);
var _ch = animcurve_get_channel(_cur,"width");
var _width = animcurve_channel_evaluate(_ch,prec);

var _w = room_width;
var _h = room_height;

var	_c1 = c_black
var _c2 = #930e12//#EE1C24
draw_set_all(1,c_white,font_announce_small,fa_center,fa_middle)

draw_text_ext_transformed_colour(x,y,text,_h*0.04,_w*0.5,2 * _width,2,0,_c1,_c1,_c2, _c2, _a)
		