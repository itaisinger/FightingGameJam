/// @description Insert description here
// You can write your code in this editor

/// TOP LOGIC
is_echo = false;
max_hp = 100;
hp = max_hp;
dir = 1;

/// MOVEMENT
xadd = 0;
yadd = 0;
walkspd = 5;

/// STATES
state = 0;
state_previous = state;
state_frames = 0;		//how many frames we are in this state
enum STATES{
	idle,
	walk,
	air,
	light,
	heavy,
	special,
	air_light,
	air_heavy,
	air_special,
	stun,
	air_stun,
	echo,
	dead,
	dodge,
	parry,
}
function change_state(new_state){
	state_count = 0;
	state_prev = state;
	state = new_state;
	sprite_index = states_sprites[new_state];
	image_index = 0;
}


/// INPUT
current_input = -1;		//holds the input object for the current frame.
echo_record_arr = [];

get_input = function(){
	return new scr_frame_input();
}


/// VISUALS
states_sprites = [];
states_sprites[STATES.idle] = spr_fighter_idle;
states_sprites[STATES.walk] = spr_fighter_walk;
states_sprites[STATES.light] = spr_fighter_light;

//state functions
arr_state_functions = [];
arr_state_functions[STATES.idle] = function(){
	
	xadd = 0;
	yadd = 0;
	
	//left
	if(input.get_input(INPUT.left)){
		dir = -1;
		change_state(STATES.walk);
	}
	//right
	if(input.get_input(INPUT.right)){
		dir = 1;
		change_state(STATES.walk);
	}
	//jump
	
	//light
	
	//heavy
	
	//parry
	
	//dodge
	
}
arr_state_functions[STATES.walk] = function(){
	
	xadd = dir * walkspd;
	yadd = 0;
	
	//turn
	if(input.get_input(INPUT.left) and dir == 1)
	{
		dir = -1;
	}
	else if(input.get_input(INPUT.right) and dir == -1)
	{
		dir = 1;
	}
	
	//stop
	if(!input.get_input(INPUT.right) and !input.get_input(INPUT.left))
	{
		change_state(STATES.idle);
	}
	
	//jump
}














