switch(room){
	case rm_match:
		state = GAME_STATES.match;
		start_match(obj_skater,obj_skater);
		obj_ui.set_announce_text("3");
		countdown = 3;
		cnt = 60;
		break;
	
	case rm_menu:
		state = GAME_STATES.menu;
	break;
}