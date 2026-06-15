switch(state){
	
	#region rebinds
	
	case GAME_STATES.keybinds:
	
	//go back
	if(keyboard_check_pressed(vk_escape))
		room_trans(rm_menu);		
	
	break;
	
	#endregion
	#region menu
	
	case GAME_STATES.menu:
		
		if(instance_exists(obj_tutorial)) exit;
		
		var _input = [];
		_input[0] = new FrameInput(true);
		_input[1] = new FrameInput(false);
		
		draw_set_all(1,c_white,font_main,fa_left,fa_top);
		for(var i=0; i < array_length(_input[0].arr); i++){
			draw_text(20,20+string_height("G")*1.1*i,_input[0].arr[i]);
		}
		
		if(!player_is_confirmed[2]){
			for(var i=0; i < 2; i++){
			
				//choose character
				if(!player_is_confirmed[i]){
					if(_input[i].is_pressed(INPUT.right_press)){
						chosen_characters[i]++;
						if(chosen_characters[i] == CHARACTERS.grape and !is_graped_unlocked) chosen_characters[i]++
						play_sfx(sfx_character_swap,0,0,[0.7,1.3])
					}
					if(_input[i].is_pressed(INPUT.left_press)){
						chosen_characters[i]--;
						if(chosen_characters[i] == CHARACTERS.grape and !is_graped_unlocked) chosen_characters[i]--;
						play_sfx(sfx_character_swap,0,0,[0.7,1.3])
					}
				
					if(chosen_characters[i] < 0) chosen_characters[i] = array_length(arr_characters)-1;
					if(chosen_characters[i] >= array_length(arr_characters)) chosen_characters[i] = 0;
			
				}
			
				//confirm choice
				if(_input[i].is_pressed(INPUT.echo)){
				
					player_is_confirmed[i] = !player_is_confirmed[i]
					if(player_is_confirmed[i]) {
						
						//sfx
						play_sfx(arr_characters[chosen_characters[i]].name_sfx)
						
						//vfx
						instance_create_depth(room_width*(0.2 + 0.6*(i == 0)),room_height*0.425,depth+1,obj_text_fade,{
							text: arr_characters[chosen_characters[i]].name
						})
						port_flash[i] = 1;
					}
				}
			}
		
			if(player_is_confirmed[0] and player_is_confirmed[1]){
				call_later(1,time_source_units_seconds,function(){room_trans(rm_match);});
				player_is_confirmed[2] = 1;
			}
		}
			
		//tutorial
		if(keyboard_check_pressed(ord("T")))
			instance_create_depth(0,0,0,obj_tutorial);
			
		//keybinds
		if(keyboard_check_pressed(ord("I")))
			room_trans(rm_rebind);
		
		//unlock grape
		if(!is_graped_unlocked)
		{
			if(string_ends_with(keyboard_string,"grape"))
			{
				is_graped_unlocked = true;
				chosen_characters[0] = CHARACTERS.grape;
				chosen_characters[1] = CHARACTERS.grape;
				play_sfx(sfx_parry) 
			}
			// hitmarks when aproaching grape
			if (!variable_instance_exists(id, "grape_prefixes")){
			    grape_prefixes = ["g", "gr", "gra", "grap", "grape"];
			
				grape_pitches = {"g":1,"gr":1.5,"gra":0.5,"grap":0.9,"grape":2}
			    last_grape_prefix = ""; }
			var current_prefix = "";
			for (var i = 0; i < array_length(grape_prefixes); i++)
			{
				if (string_ends_with(keyboard_string, grape_prefixes[i]))
				{
				    current_prefix = grape_prefixes[i];
				}
			}
			
			if (current_prefix != "" && current_prefix != last_grape_prefix){
				if(playingsfx !=0){stop_sfx(playingsfx)}
				playingsfx=play_sfx(sfx_correct,,,grape_pitches[$current_prefix],);
			}
			last_grape_prefix = current_prefix;
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
			inst_ui.set_announce_text("KO!!")
			with(obj_gameplay_object) step_delay = KO_STEP_DELAY;
			step_delay = KO_STEP_DELAY;
			
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
		
			call_later(6.5,time_source_units_seconds,function(){room_trans(rm_menu)});
		}
				
		
	break;
	#endregion
}

//fullscreen
if(keyboard_check_pressed(vk_f4)) window_set_fullscreen(!window_get_fullscreen())
if(keyboard_check_pressed(vk_f2)) screen_save(date_current_datetime())