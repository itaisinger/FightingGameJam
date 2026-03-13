/// @description Insert description here
// You can write your code in this editor

/// TOP LOGIC
is_echo = false;
max_hp = 100;
hp = max_hp;
dir = 1;
echo_charges_max = 3;
echo_charges_remain = echo_charges_max;

/// MOVEMENT
xadd = 0;
yadd = 0;
walkspd = 7;
grav = 0.7;
air_drift_spd = walkspd*0.05;
max_air_spd = walkspd * 1.5;
air_fric = 0.05;
ground_fric = 1;
slide_fric = ground_fric * 0.4;	//used to slide when entering states that slide
jumpforce_y = 12;
jumpforce_x = 6;

dodge_step_remain = 0;

/// EXTRA STATS
dodge_step_max = 11;






function collision(){
	
	var _mask_prev = mask_index
	mask_index = mask_fighter_col;

	//push out of floor
	while (place_meeting(x,y,obj_floor))
		y--;
		
	//push out of walls
	while (place_meeting(x,y,obj_wall)){
		var _wall = instance_place(x,y,obj_wall)
		x -= sign(_wall.image_xscale);
	}
	
	//hor
	while (place_meeting(x+xadd,y,obj_wall)) xadd = approach(xadd,1,0);
	
	//ver
	while (place_meeting(x,y+yadd,obj_floor)) yadd = approach(yadd,1,0);
	
	mask_index = _mask_prev;
}

/// STATES
state = 0;
state_prev = state;
state_changed = false;
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

/// ECHO
echo_record_arr = [];	//constantly updating last inputs. for echo saves the inputs to play.
echo_saved = -1;		//hold the saved sequence. returns to -1 after use.
echo_size = room_speed * 3;
frames_lived = 0;		//used by echos to count their current step

function create_echo(){
	var _inst = instance_create_depth(x,y,depth-1,obj_fighter);
	_inst.make_echo(echo_saved);
	echo_saved = -1;
}
function make_echo(input_arr){
	echo_saved = -1;
	echo_record_arr = input_arr;
	is_echo = true;
	hp = 1;
}

/// VISUALS
anim_done = false;

states_sprites = [];
states_sprites[STATES.idle]			= spr_fighter_idle;
states_sprites[STATES.jump_squat]	= spr_fighter_jump_squat;
states_sprites[STATES.walk]			= spr_fighter_walk;
states_sprites[STATES.light]		= spr_fighter_light;
states_sprites[STATES.air]			= spr_fighter_air;
states_sprites[STATES.echo]			= spr_fighter_echo;
mask_index = spr_fighter_idle


//state functions
arr_state_functions = [];
arr_state_functions[STATES.idle] = function(){
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//fall failsafe
	if(!place_meeting(x,y+1,obj_floor))
		change_state(STATES.air);
	
	//left
	if(input.is_pressed(INPUT.left) and !input.is_pressed(INPUT.right)){
		dir = -1;
		change_state(STATES.walk);
	}
	//right
	if(input.is_pressed(INPUT.right) and !input.is_pressed(INPUT.left)){
		dir = 1;
		change_state(STATES.walk);
	}
	//jump
	if(input.is_pressed(INPUT.up)) change_state(STATES.jump_squat);
	
	
	//light
	
	//heavy
	
	//parry
	
	//dodge
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.right)){
		dir = 1;
		change_state(STATES.dodge);
	}
	
	//capture echo
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.down) and echo_charges_remain > 0 and echo_saved == -1)
		change_state(STATES.echo);
	
	//play echo
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.down) and echo_saved != -1)
		create_echo()
}
arr_state_functions[STATES.jump_squat] = function(){
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(input.is_pressed(INPUT.right)) dir = 1;
	if(input.is_pressed(INPUT.left)) dir = -1;
	
	if(anim_done)
	{
		xadd = jumpforce_x * (input.is_pressed(INPUT.right) -  input.is_pressed(INPUT.left))
		yadd = -jumpforce_y;
		
		//nuetral jump is higher
		if(xadd == 0) yadd *= 1.25;
		
		change_state(STATES.air);
	}
}
arr_state_functions[STATES.walk] = function(){
	
	yadd = 0;
	xadd_dest = dir * walkspd;
	
	//if moving fast, slow down. otherwise, snap to speed
	if(abs(xadd) < abs(xadd_dest)) xadd = xadd_dest;
	else xadd = approach(xadd,ground_fric,xadd_dest);
	
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
	if(place_meeting(x,y+1,obj_floor))
		change_state(STATES.idle);
		
	//air light
	
	//air heavy
	
	//air special
	
	//air dodge
}
arr_state_functions[STATES.echo] = function(){
	
	//consume charge
	if(state_changed)
		echo_charges_remain--;
	
	yadd = 0;
	xadd = approach(xadd,slide_fric,0)
	
	if(anim_done){
		//echo done
		if(is_echo) instance_destroy();
		//record echo
		else{
			echo_saved = []
			array_copy(echo_saved,0,echo_record_arr,0,array_length(echo_record_arr));
			change_state(STATES.idle);
		}
	}
}







