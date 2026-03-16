switch(state){
	
	#region menu
	
	case GAME_STATES.menu:
		if(keyboard_check_pressed(vk_enter))
			room_goto(rm_match);
		
		var _input = [];
		_input[0] = new FrameInput(true);
		_input[1] = new FrameInput(false);
		
		draw_set_all(1,c_white,font_main,fa_left,fa_top);
		for(var i=0; i < array_length(_input[0].arr); i++){
			draw_text(20,20+string_height("G")*1.1*i,_input[0].arr[i]);
		}
		
		for(var i=0; i < 2; i++){
			if(_input[i].is_pressed(INPUT.right_press))
				chosen_characters[i]++;
			if(_input[i].is_pressed(INPUT.left_press))
				chosen_characters[i]--;
				
			if(chosen_characters[i] < 0) chosen_characters[i] = array_length(arr_characters)-1;
			if(chosen_characters[i] >= array_length(arr_characters)) chosen_characters[i] = 0;
		}
		
	break;
	
	#endregion
	#region match
	case GAME_STATES.match:
		
		if(cnt-- <= 0){
			
			countdown--;
			if(countdown >= -1) cnt = 60;
			
			switch(countdown)
			{
				case 2: obj_ui.set_announce_text("2"); play_sfx(sfx_2);	break;
				case 1: obj_ui.set_announce_text("1"); play_sfx(sfx_1);	break;
				case 0: 
					play_sfx(sfx_burst);
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
		var _p2_dead = inst_players[0].is_dead();
		var _p1_dead = inst_players[1].is_dead();
		
		if(_p1_dead or _p2_dead)
		{
			state = GAME_STATES.over;
			play_sfx(sfx_ko);
			//instance_destroy(obj_input)
			//instance_destroy(obj_input2)
			inst_ui.set_announce_text("KO!!")
			with(obj_character) step_delay = 3;
		
			if(_p1_dead and _p2_dead){
				call_later(3,time_source_units_seconds,function(){
					inst_ui.set_announce_text("TIE!!!")
					play_sfx(sfx_tie);	
				});
			}
			else if(_p1_dead)
				call_later(3,time_source_units_seconds,function(){
					with(obj_ui) set_announce_text(other.inst_players[0].name + "\nWINS!")
					play_sfx(inst_players[0].win_sfx);
				});
			else if(_p2_dead)
				call_later(3,time_source_units_seconds,function(){
					with(obj_ui) set_announce_text(other.inst_players[1].name + "\nWINS!")
					play_sfx(inst_players[1].win_sfx);

				});
		
			call_later(8,time_source_units_seconds,function(){room_goto(rm_menu)});
		}
				
		
	break;
	#endregion
}


//fulscreen
if(keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen())
if(keyboard_check_pressed(vk_f2)) screen_save(date_current_datetime())