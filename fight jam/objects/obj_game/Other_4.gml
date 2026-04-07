//audio_stop_all();
VinylStopAll();
cnt = room_speed*10;
step_delay = 0;

switch(room){
	case rm_match:
		state = GAME_STATES.match;
		start_match(arr_characters[chosen_characters[0]].object,arr_characters[chosen_characters[1]].object);
		obj_ui.set_announce_text("3");
		call_later(0.5,time_source_units_seconds,function(){ 
			play_sfx(sfx_3); 
			instance_create_depth(0,0,0,obj_ost); 
			countdown = 3;
			cnt = 60;
		});
		player_is_confirmed = [0,0,0];
		break;
	
	case rm_menu:
		state = GAME_STATES.menu;
		instance_create_depth(0,0,0,obj_input)
		
		call_later(0.5,time_source_units_seconds,function(){ 
			play_sfx(sfx_echo_burst);
			call_later(1,time_source_units_seconds,function(){if(room==rm_menu) VinylPlayFadeIn("menu ost",1,global.ost_vol,0.5);});
			VinylPlayFadeIn(ost_menu_fire,1,0.3*global.ost_vol,0.5)
		});
	break;
}