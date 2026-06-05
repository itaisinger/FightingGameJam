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
_s1 = 1;
_s2 = 1;
port_flash = [0,0];

//menu
player_is_confirmed = [0,0,0];
is_graped_unlocked = false;

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

enum CHARACTERS{
	joshua,
	drex,
	shon,
	minami,
	grape,	//make sure he is not in the start or end of the enum, unlock feature will break.
	spike,
}
function Character(_name,_object,_sprite,_name_sfx) constructor{
	name = _name;
	object = _object;
	sprite = _sprite;
	name_sfx = _name_sfx;
}
arr_characters[CHARACTERS.joshua]	= new Character("JOSHUA",				obj_fighter,	spr_portrait_fighter,	sfx_joshua)
arr_characters[CHARACTERS.drex]		= new Character("JOHNNY DREX",			obj_skater,		spr_portrait_skater,	sfx_johnny)
arr_characters[CHARACTERS.shon]		= new Character("SHON SHMUPS",			obj_shooter,	spr_portrait_shooter,	sfx_shon)
arr_characters[CHARACTERS.minami]	= new Character("MINAMI\nNO  KAZE",		obj_knifer,		spr_portrait_knifer,	sfx_minami)
arr_characters[CHARACTERS.spike]	= new Character("SPYKE",				obj_spyke,		spr_portrait_spyke,		sfx_spyke)
arr_characters[CHARACTERS.grape]	= new Character("GRAPE",				obj_grape,		spr_portrait_grape,		sfx_spyke)
function start_match(p1_obj=obj_fighter,p2_obj=obj_fighter){
	var _player_dis = room_width/4
	player_left_xstart	= room_width/2 + _player_dis;
	player_right_xstart = room_width/2 - _player_dis;
	
	inst_ui = instance_create_depth(0,0,0,obj_ui);
	inst_camera = instance_create_depth(0,0,0,obj_camera);
	
	inst_players[1] = instance_create_depth(player_left_xstart,floor_y+1-100,DEPTH.player,p1_obj);
	inst_players[0] = instance_create_depth(player_right_xstart,floor_y+1-100,DEPTH.player,p2_obj);
	
	inst_players[1].is_p1 = true;	//left is p1
	inst_players[0].is_p1 = false;
	inst_players[1].dir = -1;
	
	inst_players[1].outline_col = [0.0, 0.0, 1.0];

	if(p1_obj == p2_obj) {
		inst_players[1].outline_active = true;
		inst_players[0].outline_active = true;
	}
	
	inst_ui.set_players(inst_players);
}