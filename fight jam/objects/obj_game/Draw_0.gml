display_set_gui_size(480, 270);

var _w = room_width;
var _h = room_height;
//var _w = display_get_gui_width();
//var _h = display_get_gui_height();

switch(room)
{
	case rm_menu:
		
		draw_set_all(1,c_white,font_main,fa_center,fa_middle);
		if(wave(-1,1,2) > -0.5) draw_text(_w/2,_h/2,"press enter to start");
		//draw_set_font(font_announce_small)
		//var _c1 = c_black
		//var _c2 = #9E0B0F

		//draw_text_color(_w/2 - 10,_h*0.3,"ECHO",_c1,_c1,_c2,_c2,1);
		//draw_text_color(_w/2 + 10,_h*0.3 + 0.7*string_height("G"),"BURST",_c1,_c1,_c2,_c2,1);
		
		draw_sprite_ext(spr_title,0,_w/2,_h*0.3,1,1,0,c_white,1)
	break;
	
}