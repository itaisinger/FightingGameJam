/// @description Insert description here
// You can write your code in this editor

/// TOP LOGIC
is_echo = false;
max_hp = 100;
hp = max_hp;

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
arr_state_functions[STATES.idle] = function(){}