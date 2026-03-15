switch(room)
{
	case rm_menu:
		draw_set_all(1,c_white,font_main,fa_center,fa_middle);
		if(wave(-1,1,2) > -0.5) draw_text(display_get_gui_width()/2,display_get_gui_height()/2,"press enter to start");
	break;
	
}