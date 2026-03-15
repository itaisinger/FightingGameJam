switch(room){
	case rm_match:
		state = GAME_STATES.match;
		start_match(obj_fighter,obj_skater);
		obj_ui.set_announce_text("3");
		play_sfx(sfx_3)
		countdown = 3;
		cnt = 60;
		break;
	
	case rm_menu:
		state = GAME_STATES.menu;
		play_sfx(sfx_echo_burst);
	break;
}