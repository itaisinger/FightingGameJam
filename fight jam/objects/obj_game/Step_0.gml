switch(room){
	
	case rm_menu:
		if(keyboard_check_pressed(vk_enter))
			room_goto(rm_match);
	break;
	
	case rm_match:
		
		if(cnt-- <= 0){
			
			countdown--;
			if(countdown >= -1) cnt = 60;
			
			switch(countdown)
			{
				case 2: obj_ui.set_announce_text("2");	break;
				case 1: obj_ui.set_announce_text("1");	break;
				case 0: 
					obj_ui.set_announce_text("BURST!!");
					instance_create_depth(0,0,0,obj_input);
					instance_create_depth(0,0,0,obj_input2);
					break
				case -1:
					obj_ui.set_announce_text("");
					break;

			}
		}
		
		//death check

		
	break;
}


//fulscreen
if(keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen())