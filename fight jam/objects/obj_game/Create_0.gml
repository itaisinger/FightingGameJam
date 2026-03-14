//gameplay related
floor_y = 200
display_set_gui_size(480, 270);
//window_set_fullscreen(1)
announce_text = "";
cnt = 0;

function start_match(p1_obj=obj_fighter,p2_obj=obj_fighter){
	var _player_dis = room_width/4
	player_left_xstart	= room_width/2 - _player_dis;
	player_right_xstart = room_width/2 + _player_dis;
	
	inst_ui = instance_create_depth(0,0,0,obj_ui);
	
	inst_players[0] = instance_create_depth(player_left_xstart,floor_y+1,DEPTH.player,p1_obj);
	inst_players[1] = instance_create_depth(player_right_xstart,floor_y+1,DEPTH.player,p2_obj);
	
	inst_players[0].is_p1 = true;	//left is p1
	inst_players[1].is_p1 = false;
	inst_players[1].dir = -1;
	
	inst_ui.set_players(inst_players);
}