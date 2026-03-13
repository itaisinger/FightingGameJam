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
walkspd = 7;
grav = 0.7;
air_drift_spd = walkspd*0.05;
max_air_spd = walkspd * 1.5;
air_fric = 0.05;
ground_fric = 1;
jumpforce_y = 12;
jumpforce_x = 6;
function collision_movement(_xadd,_yadd){
	
	//hor
	while (place_meeting(x+_xadd,y,obj_wall)) _xadd = approach(_xadd,1,0);
	x += _xadd;
	
	//ver
	while (place_meeting(x,y+_yadd,obj_wall)) _yadd = approach(_yadd,1,0);
	y += _yadd;
}

/// STATES
state = 0;
state_previous = state;
state_count = 0;		//how many frames we are in this state
enum STATES{
	idle,
	walk,
	jump_squat,
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
input = -1;		//holds the input object for the current frame.
echo_record_arr = [];

get_input = function(){
	if(!is_echo)
		return new frame_input(true);
}


/// VISUALS
anim_done = false;

states_sprites = [];
states_sprites[STATES.idle]			= spr_fighter_idle;
states_sprites[STATES.jump_squat]	= spr_fighter_jump_squat;
states_sprites[STATES.walk]			= spr_fighter_walk;
states_sprites[STATES.light]		= spr_fighter_light;
mask_index = spr_fighter_idle


//state functions
arr_state_functions = [];
arr_state_functions[STATES.idle] = function(){
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//fall failsafe
	if(!place_meeting(x,y+1,obj_wall))
		change_state(STATES.air);
	
	//left
	if(input.is_pressed(INPUT.left)){
		dir = -1;
		change_state(STATES.walk);
	}
	//right
	if(input.is_pressed(INPUT.right)){
		dir = 1;
		change_state(STATES.walk);
	}
	//jump
	if(input.is_pressed(INPUT.up)) change_state(STATES.jump_squat);
	
	
	//light
	
	//heavy
	
	//parry
	
	//dodge
	
	//capture echo
	
}
arr_state_functions[STATES.jump_squat] = function(){
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	if(input.is_pressed(INPUT.right)) dir = 1;
	if(input.is_pressed(INPUT.left)) dir = -1;
	
	if(anim_done)
	{
		xadd = jumpforce_x * dir
		yadd = -jumpforce_y;
		change_state(STATES.air);
	}
}
arr_state_functions[STATES.walk] = function(){
	
	xadd = approach(xadd,ground_fric,dir * walkspd);
	yadd = 0;
	
	//turn
	if(input.is_pressed(INPUT.left) and dir == 1)
	{
		dir = -1;
	}
	else if(input.is_pressed(INPUT.right) and dir == -1)
	{
		dir = 1;
	}
	
	//stop
	if(!input.is_pressed(INPUT.right) and !input.is_pressed(INPUT.left))
	{
		change_state(STATES.idle);
	}
	
	//jump
	if(input.is_pressed(INPUT.up)) change_state(STATES.jump_squat);
}
arr_state_functions[STATES.air] = function(){
	yadd += grav;
	xadd = approach(xadd,air_fric,0);
	xadd += air_drift_spd * ( input.is_pressed(INPUT.right) -  input.is_pressed(INPUT.left) );
	xadd = clamp(xadd,-max_air_spd,max_air_spd)
	
	image_index = yadd > 0;
	
	//land
	if(place_meeting(x,y+1,obj_wall))
		change_state(STATES.idle);
		
	//air light
	
	//air heavy
	
	//air special
	
	//air dodge
}












