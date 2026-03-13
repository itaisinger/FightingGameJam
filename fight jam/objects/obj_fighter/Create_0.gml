/// TOP LOGIC
is_echo = false;
max_hp = 100;
hp = max_hp;
dir = 1;
echo_charges_max = 3;
echo_charges_remain = echo_charges_max;
hitpause_remain = 0;
is_p1 = true;

/// MOVEMENT
xadd = 0;
yadd = 0;
walkspd = 7;
grav = 0.7;
stun_grav = grav * 0.7;
air_drift_spd = walkspd*0.05;
max_air_spd = walkspd * 1.5;
air_fric = 0.05;
stun_air_fric = 0.4;
ground_fric = 1;
slide_fric = ground_fric * 0.4;	//used to slide when entering states that slide
jumpforce_y = 12;
jumpforce_x = 6;

dodge_step_remain = 0;
dodge_step_max = 9;

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
	image_speed = 1;
	image_speed_prev = 1;
	hurtbox = states_hurtboxes[new_state];
}

/// INPUT
input = -1;		//holds the input object for the current frame.

/// ECHO
echo_record_arr = [];	//constantly updating last inputs. for echo saves the inputs to play.
echo_saved = -1;		//hold the saved sequence. returns to -1 after use.
echo_size = room_speed * 5;
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

/// ANIMATION AND VISUALS
anim_done = false;
image_speed_prev = 1;

states_sprites = [];
states_sprites[STATES.idle]			= spr_fighter_idle;
states_sprites[STATES.jump_squat]	= spr_fighter_jump_squat;
states_sprites[STATES.walk]			= spr_fighter_walk;
states_sprites[STATES.light]		= spr_fighter_light;
states_sprites[STATES.heavy]		= spr_fighter_heavy;
states_sprites[STATES.air]			= spr_fighter_air;
states_sprites[STATES.echo]			= spr_fighter_echo;
states_sprites[STATES.dodge]		= spr_fighter_dodge;
states_sprites[STATES.stun]			= spr_fighter_hurt;
states_sprites[STATES.air_stun]		= spr_fighter_hurt;
states_sprites[STATES.dead]			= spr_fighter_dead;
states_sprites[STATES.parry]		= spr_fighter_parry;

hurtbox = hurtbox_fighter_idle;
states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_empty;
states_hurtboxes[STATES.jump_squat]	= hurtbox_fighter_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
states_hurtboxes[STATES.light]		= hurtbox_fighter_light;
states_hurtboxes[STATES.heavy]		= hurtbox_fighter_heavy;
states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
states_hurtboxes[STATES.echo]		= hurtbox_fighter_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_fighter_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_fighter_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_fighter_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_fighter_hurt;
states_hurtboxes[STATES.parry]		= hurtbox_fighter_parry;

mask_index = spr_fighter_idle


/// ATTACKS DATA (overrided in different characters)
hitbox_data[STATES.light]		= new HitboxData(hitbox_fighter_light,3,25,5,3,5,0,0);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_fighter_heavy,8,80,15,6,9,0,1);
hitbox_data[STATES.special]		= new HitboxData(hitbox_fighter_light,3,25,5,3,5,0,0);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_light,3,25,5,3,5,0,0);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_light,3,25,5,3,5,0,0);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_light,3,25,5,3,5,0,0);
inst_hitbox = noone;	//saves the currently active hitbox.

//state functions
arr_state_functions = [];
arr_state_functions[STATES.idle] = function(){
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//fall failsafe
	if(!is_grounded())
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
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);

	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//parry
	
	//dodge right
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.right)){
		dir = 1;
		change_state(STATES.dodge);
	}
		
	//dodge left
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.left)){
		dir = -1;
		change_state(STATES.dodge);
	}
	
	//capture echo
	//if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.down) and echo_charges_remain > 0 and echo_saved == -1)
	if(input.is_pressed(INPUT.dodge) and echo_charges_remain > 0 and echo_saved == -1)
		change_state(STATES.echo);
	
	//play echo
	if(input.is_pressed(INPUT.dodge) and echo_saved != -1)
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
	
	//dodge right
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.right)){
		dir = 1;
		change_state(STATES.dodge);
	}
		
	//dodge left
	if(input.is_pressed(INPUT.dodge) and input.is_pressed(INPUT.left)){
		dir = -1;
		change_state(STATES.dodge);
	}
		
	//light
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//echo
	
	//parry
}
arr_state_functions[STATES.air] = function(){
	yadd += grav;
	xadd = approach(xadd,air_fric,0);
	xadd += air_drift_spd * ( input.is_pressed(INPUT.right) -  input.is_pressed(INPUT.left) );
	xadd = clamp(xadd,-max_air_spd,max_air_spd)
	
	image_index = yadd > 0;
	
	//land
	if(is_grounded())
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
arr_state_functions[STATES.dodge] = function(){
	
	if(state_changed)
	{
		xadd = dodge_step_max*dir;
	}
	
	xadd = approach(xadd,slide_fric*0.5,0);
	//xadd = dir*dodge_step_remain;
	//dodge_step_remain = approach(dodge_step_remain,1,0);
	
	if(anim_done)
		change_state(STATES.idle);
}
arr_state_functions[STATES.stun] = function(){
	
	//movement
	yadd = 0;
	xadd = approach(xadd,ground_fric,0);
	
	//exit stun
	if(stun_remain-- <= 0)
		change_state(STATES.idle);
}
arr_state_functions[STATES.air_stun] = function(){
	
	yadd += stun_grav;
	xadd = approach(xadd,stun_air_fric,0);
	
	if(stun_remain-- <= 0)
		change_state(STATES.air);
		
	if(is_grounded())
		change_state(STATES.idle);
}
arr_state_functions[STATES.dead] = function(){
	if(is_grounded())
	{
		xadd = approach(xadd,slide_fric,0);
		yadd = 0;
	}
	else
	{
		xadd = approach(xadd,air_fric*0.8,0);
		yadd += stun_grav*0.8	
	}
	
	if(anim_done){
		image_index = -1;
		image_speed = 0;
	}
}
arr_state_functions[STATES.light] = function(){
	
	if(state_changed){
		create_hitbox(hitbox_data[STATES.light])
		xadd += dir * 2
	}
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.heavy] = function(){
	
	if(state_changed){
		create_hitbox(hitbox_data[STATES.heavy])
		xadd += dir * 2
	}
	
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(anim_done)
		change_state(STATES.idle)
}

//methods
function hit(damage,knockx,knocky,stun,hitpause,is_launch){
	
	//abort if already dead (or should we?)
	if(state == STATES.dead)
		exit;
	
	//cancel active hitbox
	instance_destroy(inst_hitbox);
	
	hp = max(hp-damage,0);
	
	//die
	if(hp == 0) {
		change_state(STATES.dead);
		return;
	}

	//apply stun frames	
	stun_remain = stun;

	yadd = -knocky;
	xadd = knockx;
	
	//if already stunned in air, adjust kb and stay in state
	if(state == STATES.air_stun)
	{
		xadd *= 1.5;
		yadd *= 0.6;
	}
	else if (is_launch){
		change_state(STATES.air_stun)
	}
	else change_state(STATES.stun);
	
	//hitpause
	hitpause_remain = hitpause;
}
function is_grounded()
{	
	var _mask_prev = mask_index
	mask_index = mask_fighter_col;
	var _ret = place_meeting(x,y+1,obj_floor) and yadd >= 0
	mask_index = _mask_prev;
	return _ret;
}
function create_hitbox(_hitbox_data){
	
	if(inst_hitbox != noone)
		log("multipile hitboxes!")
	
	inst_hitbox = instance_create_depth(x,y,depth,obj_hitbox,_hitbox_data);
	inst_hitbox.dir = dir;
	inst_hitbox.image_xscale = dir;
	inst_hitbox.parent = self;
	
}
function give_echo(){
	echo_charges_remain++;
}
