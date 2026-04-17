if(instance_number(obj_game) > 1) {
	instance_destroy();
	exit;
}

__VinylConfigJSON();
scr_macros();
instance_create_depth(0,0,0,obj_transition);

depth = 0;
//gameplay related
floor_y = 896;
step_delay = 0;  

//ui
display_set_gui_size(480, 270); 
announce_text = "";
cnt = 0;
cd = 0;
image = 0;

//menu
player_is_confirmed = [0,0,0];


global.sfx_volume = 0.4;
global.ost_vol = 1;

//states
state = 0;
enum GAME_STATES{
	menu,
	match,
	over,
}

//menu
chosen_characters = [0,0,0];

function Character(_name,_object,_sprite,_name_sfx) constructor{
	name = _name;
	object = _object;
	sprite = _sprite;
	name_sfx = _name_sfx;
}
arr_characters[0] = new Character("JOSHUA",			 obj_fighter,	spr_portrait_fighter,	sfx_joshua)
arr_characters[1] = new Character("JOHNNY DREX",	 obj_skater,	spr_portrait_skater,	sfx_johnny)
arr_characters[2] = new Character("SHON SHMUPS",	 obj_shooter,	spr_portrait_shooter,	sfx_shon)
arr_characters[3] = new Character("MINAMI\nNO  KAZE",obj_knifer,	spr_portrait_knifer,	sfx_minami)
arr_characters[4] = new Character("SPYKE",			 obj_spyke,		spr_portrait_spyke,		sfx_spyke)
function start_match(p1_obj=obj_fighter,p2_obj=obj_fighter){
	var _player_dis = room_width/4
	player_left_xstart	= room_width/2 + _player_dis;
	player_right_xstart = room_width/2 - _player_dis;
	
	inst_ui = instance_create_depth(0,0,0,obj_ui);
	
	inst_players[1] = instance_create_depth(player_left_xstart,floor_y+1-100,DEPTH.player,p1_obj);
	inst_players[0] = instance_create_depth(player_right_xstart,floor_y+1-100,DEPTH.player,p2_obj);
	
	inst_players[1].is_p1 = true;	//left is p1
	inst_players[0].is_p1 = false;
	inst_players[1].dir = -1;
	
	inst_ui.set_players(inst_players);
}