audio_stop_all();
step_delay = 0;

switch(room){
	case rm_match:
		state = GAME_STATES.match;
		start_match(arr_characters[chosen_characters[0]].object,arr_characters[chosen_characters[1]].object);
		obj_ui.set_announce_text("3");
		play_sfx(sfx_3)
		countdown = 3;
		cnt = 60;
		instance_create_depth(0,0,0,obj_ost);
		break;
	
	case rm_menu:
		state = GAME_STATES.menu;
		instance_create_depth(0,0,0,obj_input)
		instance_create_depth(0,0,0,obj_input2)
		play_sfx(sfx_echo_burst);
	break;
}