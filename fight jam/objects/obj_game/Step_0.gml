switch(state){
	
	case GAME_STATES.menu:
		if(keyboard_check_pressed(vk_enter))
			room_goto(rm_match);
	break;
	
	case GAME_STATES.match:
		
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
		var _p2_dead = inst_players[1].is_dead();
		var _p1_dead = inst_players[0].is_dead();
		
		if(_p1_dead or _p2_dead)
		{
			state = GAME_STATES.over;
			
			instance_destroy(obj_input)
			instance_destroy(obj_input2)
			inst_ui.set_announce_text("KO!!")
		
			if(_p1_dead and _p2_dead){
				call_later(2,time_source_units_seconds,function(){inst_ui.set_announce_text("TIE!!!")});
			}
			else if(_p1_dead)
				call_later(2,time_source_units_seconds,function(){with(obj_ui) set_announce_text(other.inst_players[1].name + "\nWON!")});
			else if(_p2_dead)
				call_later(2,time_source_units_seconds,function(){with(obj_ui) set_announce_text(other.inst_players[0].name + "\nWON!")});
		
			call_later(6,time_source_units_seconds,function(){room_goto(rm_menu)});
		}
				
		
	break;
}


//fulscreen
if(keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen())