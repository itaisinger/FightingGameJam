switch(room){
	
	case rm_menu:
		if(keyboard_check_pressed(vk_enter))
			room_goto(rm_match);
	break;
	
	case rm_match:
		
		//death check
		
	break;
}


//fulscreen
if(keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen())