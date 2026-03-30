event_inherited();

/// TOP LOGIC
is_echo = false;
max_hp = 120;
hp = max_hp;
dir = 1;
echo_charges_max = 3;
echo_charges_remain = echo_charges_max;
hitpause_remain = 0;
is_p1 = true;

combo_counter = 0;
combo_counter_damage = 0;

name = "JOSHUA"
win_sfx = sfx_jhoshua_wins;



/// MOVEMENT
xadd = 0;
yadd = 0;
walkspd = 7;
grav = 0.6;
stun_grav = grav * 0.4;
air_drift_spd = walkspd*0.03;
max_air_spd = walkspd * 10;
air_fric = 0.05;
stun_air_fric = air_fric * 0.25;
ground_fric = 1;
slide_fric = ground_fric * 0.4;	//used to slide when entering states that slide

jumpforce_y = 12;
jumpforce_x = walkspd * 0.8;
jump_traj_x = 0; //base xadd set when jumping. cant stray away from this too much.
max_stray = walkspd * 0.6;
max_stray_back = walkspd*0.4;

dodge_step_remain = 0;
dodge_step_max = 9;

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
	land,
	light,
	light2,
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
	teleport,
	
	max,
}


stun_remain = 0;

/// INPUT
input = -1;		//holds the input object for the current frame.

/// ECHO
echo_record_arr = [];	//constantly updating last inputs. for echo saves the inputs to play.
echo_saved = -1;		//hold the saved sequence. returns to -1 after use.
echo_size = room_speed * 5;
frames_lived = 0;		//used by echos to count their current step


/// TP
tp_x = -1;
echo_tp_cost = 1;

/// ANIMATION AND VISUALS
anim_done = false;
image_speed_prev = 1;
image_index_prev = 0;
_xshake = 0;
_yshake = 0;
floor_y = -100;
depth = DEPTH.player;
afterimage_remain = 0;

shake_max = 10;
disable_draw = false;

//animation stats
special_trans_grace_length = 8; //how many frames into heavy/light you can transition to special
turnaround_grace_length = 8; //how many frames into heavy/light you can transition to special
landing_lag = 10;

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
states_sprites[STATES.teleport]		= spr_fighter_tp;
states_sprites[STATES.special]		= spr_fighter_special;
states_sprites[STATES.land]			= spr_fighter_land;
states_sprites[STATES.air_light]	= spr_fighter_air_light;
states_sprites[STATES.air_heavy]	= spr_fighter_air_heavy;
states_sprites[STATES.air_special]	= spr_fighter_air_special;

hurtbox = hurtbox_fighter_idle;
states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_fighter_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_fighter_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
states_hurtboxes[STATES.light]		= hurtbox_fighter_light;
states_hurtboxes[STATES.heavy]		= hurtbox_fighter_heavy;
states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
states_hurtboxes[STATES.echo]		= hurtbox_fighter_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_fighter_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_fighter_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_fighter_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_fighter_dead;
states_hurtboxes[STATES.parry]		= hurtbox_fighter_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
states_hurtboxes[STATES.special]	= hurtbox_fighter_special;
states_hurtboxes[STATES.land]		= hurtbox_fighter_land;
states_hurtboxes[STATES.air_light]	= hurtbox_fighter_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_fighter_air_heavy;
states_hurtboxes[STATES.air_special]= hurtbox_fighter_air_special;

mask_index = spr_fighter_idle

/// ATTACKS DATA (overrided in different characters)
hitbox_data = array_create(STATES.max,-1)
hitbox_data[STATES.light]		= new HitboxData(hitbox_fighter_light,3,45,5,1,4,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_fighter_heavy,8,100,15,6,9,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_fighter_special,12,60,10,7,5,1,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_air_light,5,60,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_fighter_air_heavy,10,90,10,3,5,0,0,false);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_fighter_air_special,4,20,5,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_fighter_parry,1,180,20,3,3,1,false,true);
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

	//dodge
	if(input.is_pressed(INPUT.dodge))
	{	
		//dodge right
		if(input.is_pressed(INPUT.right)){
			dir = 1;
			change_state(STATES.dodge);
		}
		
		//dodge left
		else if(input.is_pressed(INPUT.left)){
			dir = -1;
			change_state(STATES.dodge);
		}
		
		//parry
		else change_state(STATES.parry);	
	}
	
	//capture echo
	if(input.is_pressed(INPUT.echo) and echo_charges_remain > 0 and echo_saved == -1)
		change_state(STATES.echo);
}
arr_state_functions[STATES.jump_squat] = function(){
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(input.is_pressed(INPUT.right)) dir = 1;
	if(input.is_pressed(INPUT.left)) dir = -1;
	
	if(anim_done)
	{
		xadd = jumpforce_x * sign(input.is_pressed(INPUT.right) -  input.is_pressed(INPUT.left))
		yadd = -jumpforce_y;
		jump_traj_x = xadd;
		
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
	
	//failsafe
	if(!is_grounded()){
		change_state(STATES.air);
		return;
	}
	
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
	
	//dodge
	if(input.is_pressed(INPUT.dodge))
	{	
		//dodge right
		if(input.is_pressed(INPUT.right)){
			dir = 1;
			change_state(STATES.dodge);
		}
		
		//dodge left
		else if(input.is_pressed(INPUT.left)){
			dir = -1;
			change_state(STATES.dodge);
		}
			
		//parry
		else change_state(STATES.parry);	
	}
	
	//capture echo
	if(input.is_pressed(INPUT.echo) and echo_charges_remain > 0 and echo_saved == -1)
		change_state(STATES.echo);
		
	
	//light
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//special
	if(input.is_pressed(INPUT.special)) change_state(STATES.special);
}
arr_state_functions[STATES.land] = function(){
	
	yadd = 0;
	xadd = approach(xadd,ground_fric,0);
	
	if(state_count >= landing_lag){
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
	}
	
	//jump
	if(input.is_pressed(INPUT.up)) change_state(STATES.jump_squat);
	
	//dodge
	if(input.is_pressed(INPUT.dodge))
	{	
		//dodge right
		if(input.is_pressed(INPUT.right)){
			dir = 1;
			change_state(STATES.dodge);
		}
		
		//dodge left
		else if(input.is_pressed(INPUT.left)){
			dir = -1;
			change_state(STATES.dodge);
		}
		
		//parry
		else change_state(STATES.parry);	
	}
	
	//light
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//special
	if(input.is_pressed(INPUT.special)) change_state(STATES.special);
	
	//done
	if(anim_done)
		change_state(STATES.idle);
}
arr_state_functions[STATES.air] = function(){
	
	image_speed = 0;
	yadd += grav;
	xadd = approach(xadd,air_fric,0);
	xadd += air_drift_spd * ( input.is_pressed(INPUT.right) -  input.is_pressed(INPUT.left) );
	
	//clamp for max stray from original traj
	if(dir == 1)
	{
		xadd = clamp(xadd,jump_traj_x-max_stray_back,jump_traj_x+max_stray);
	}
	else
	{
		xadd = clamp(xadd,jump_traj_x-max_stray,jump_traj_x+max_stray_back);
	}
	
	image_index = yadd > 0;
	
	//land
	if(is_grounded())
		change_state(STATES.idle);
	
	//light
	if(input.is_pressed(INPUT.light))
		change_state(STATES.air_light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy))
		change_state(STATES.air_heavy);
	
	//special
	if(input.is_pressed(INPUT.special) or (input.is_pressed(INPUT.light) and input.is_pressed(INPUT.heavy)))
		change_state(STATES.air_special);
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
			tp_x = x;
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
	xadd = approach(xadd,ground_fric*3,0);
	stun_remain = max(0,stun_remain--);
	
	//exit stun
	if(stun_remain-- <= 0)
		change_state(STATES.idle);
}
arr_state_functions[STATES.air_stun] = function(){
	
	yadd += stun_grav;
	xadd = approach(xadd,stun_air_fric,0);
	
	if(stun_remain-- <= 0){
		jump_traj_x = xadd;
		change_state(STATES.air);	
	}
		
	if(is_grounded()){
		stun_remain = 0;
		
		if(input.is_pressed(INPUT.dodge)){
			if(input.is_pressed(INPUT.right)) dir = 1;
			if(input.is_pressed(INPUT.left)) dir = -1;
			
			change_state(STATES.dodge)
		}
		else change_state(STATES.land);
	}
}
arr_state_functions[STATES.dead] = function(){
	if(is_grounded())
	{
		xadd = approach(xadd,slide_fric,0);
		yadd = 0;
		image_index = image_number-0.1;
	}
	else
	{
		xadd = approach(xadd,air_fric*0.8,0);
		yadd += stun_grav*0.8	
		image_index = min(image_index,image_number-1.1 - 1*(yadd<0));
	}
	
	if(anim_done){
		image_index = image_number-0.1;
		image_speed = 0;
	}
}
arr_state_functions[STATES.light] = function(){
	
	if(state_changed){
		xadd += dir * 2
	}
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	//link to heavy
	if(image_index >= 2 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.heavy);
	}
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.heavy] = function(){
	
	if(state_changed){
		xadd += dir * 2
	}
	
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.parry] = function()
{
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	if(anim_done)
	{
		change_state(STATES.idle);
	}
	
	
}
arr_state_functions[STATES.teleport] = function()
{
	if(state_changed){
		__grav_mult = 0;
		__done = false;
	}
	
	if(reached_frame(4))
	{
		__done = true;
		__grav_mult = 0.5;
		yadd = -jumpforce_y/2;
	}
	
	yadd = approach(yadd,grav * __grav_mult,0);
	xadd = 0;
	
	if(__done)
	{
		//light
		if(input.is_pressed(INPUT.light))
			change_state(STATES.air_light);
	
		//heavy
		if(input.is_pressed(INPUT.light))
			change_state(STATES.air_light);
		
		//special
		if(input.is_pressed(INPUT.light))
			change_state(STATES.air_light);
		
		if(anim_done)
			change_state(STATES.air);
		
		//land
		if(is_grounded())
			change_state(STATES.idle)
	}
}
arr_state_functions[STATES.special] = function()
{
		
	xadd = approach(xadd,ground_fric*1.2,0);
	yadd = 0;
	
	if(reached_frame(4)){
		xadd = 30 * dir;
	}
	
	if(anim_done){
		change_state(STATES.idle);
	}
}
arr_state_functions[STATES.air_light] = function(){
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	//link to heavy
	if(image_index >= 3 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.air_heavy);
		image_index += 2;
	}
	
	if(anim_done)
		change_state(STATES.air)
	
	//land
	if(is_grounded())
	{
		if is_hit_success()
			change_state(STATES.idle)
		else
			change_state(STATES.land);
	}
}
arr_state_functions[STATES.air_heavy] = function(){
	
	if(state_changed)
	{
		yadd = -jumpforce_y/2;
	}
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	if(anim_done)
		change_state(STATES.air)
	
	//land
	if(is_grounded())
	{
		if is_hit_success()
			change_state(STATES.idle)
		else
			change_state(STATES.land);
	}
}
arr_state_functions[STATES.air_special] = function(){
	
	if(state_changed)
	{
		__grav_mult = 0;
		__grav_multx = 8;
		yadd = 0;
	}
	
	if(reached_frame(3))
	{
		__grav_mult = 0;
		xadd = dir * 17;
		__grav_multx = 1
		yadd = 2;
	}
	
	if(reached_frame(4))
	{
		create_hitbox(hitbox_data[STATES.air_special]);
		inst_hitbox.image_index = image_index;
	}
	
	if(reached_frame(5))
	{
		//with(inst_hitbox) instance_destroy();
		create_hitbox(hitbox_data[STATES.air_special]);
		inst_hitbox.image_index = image_index;
	}
	
	if(reached_frame(6)){
		__grav_mult = 0.5;
	}
	
	//jump cancel
	if(instance_exists(inst_hitbox) and array_length(inst_hitbox.arr_hits) > 0 and input.is_pressed(INPUT.up)){
		change_state(STATES.air)
		yadd = -jumpforce_y;
		xadd = dir * jumpforce_x;
	}
		
	
	yadd += grav * __grav_mult;
	xadd = approach(xadd,air_fric*__grav_multx,0);
	
	//land
	if(is_grounded())
	{
		if is_hit_success()
			change_state(STATES.idle)
		else
			change_state(STATES.land);
	}
		
	if(anim_done)
		change_state(STATES.air);
}

//methods
function change_state(new_state){
	state_count = 0;
	state_prev = state;
	state = new_state;
	sprite_index = states_sprites[new_state];
	image_index = 0;
	image_speed = 1;
	image_index_prev = 0;
	image_speed_prev = 1;
	hurtbox = states_hurtboxes[new_state];
	afterimage_remain = 0;
	
	with(inst_hitbox) instance_destroy();
	
	if(hitbox_data[new_state] != -1)
		create_hitbox(hitbox_data[new_state]);
	
	if(new_state == STATES.stun or new_state == STATES.air_stun)
		image_index = irandom(1)
	else{
		combo_counter = 0;
		combo_counter_damage = 0;	
	}
}
function hit(damage,knockx,knocky,stun,hitpause,is_launch){
	
	var _falloff = get_damage_falloff();
	damage *= _falloff
	knockx /= _falloff;
	knocky /= _falloff;
	
	combo_counter_damage += damage;
	combo_counter++;
	
	//abort if already dead (or should we?)
	if(state == STATES.dead)
		exit;
	
	//cancel active hitbox
	instance_destroy(inst_hitbox);
	
	hp = max(hp-damage,0);
	
	xadd = knockx;
	yadd = -knocky;
	
	//die
	if(hp == 0) {
		change_state(STATES.dead);
		return;
	}

	//apply stun frames	
	stun_remain = stun;

	//if already stunned in air, adjust kb and stay in state
	if(state == STATES.air_stun)
	{
		xadd *= 1.5;
		yadd *= 0.6;
	}
	else if (is_launch or !is_grounded()){
		yadd = -knocky;
		change_state(STATES.air_stun)
	}
	else {
		change_state(STATES.stun);
		yadd = 0;
	}
	
	//hitpause
	hitpause_remain = hitpause;
}
function is_grounded()
{	
	var _mask_prev = mask_index
	mask_index = mask_fighter_col;
	var _ret = place_meeting(x,y+1,obj_floor) and yadd >= 0
	mask_index = _mask_prev;
	if(_ret) floor_y = y+1;
	return _ret;
}
function give_echo(){
	echo_charges_remain++;
}
function reached_frame(index) //return true if this is the first frame that we reached this sub image.
{
	return (floor(image_index) == index and floor(image_index_prev) < index)
}
function is_hit_success()
{
	with(inst_hitbox) return array_length(arr_hits) > 0
	return false
}
function is_dead(){
	return state == STATES.dead;
}
function create_echo(){
	var _inst = instance_create_depth(x,y,depth-1,object_index);
	_inst.make_echo(echo_saved);
	_inst.is_p1 = is_p1;
	echo_saved = -1;
}
function make_echo(input_arr){
	echo_saved = -1;
	echo_record_arr = input_arr;
	is_echo = true;
	hp = 1;
}
function get_damage_falloff()	//returns a mult on damage for long combos
{
	return 1-map_value(combo_counter_damage,0,max_hp,0,0.7)
}
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
		if(place_meeting(x+xadd,y,obj_wall) and state == STATES.air_stun){ xadd *= -1; dir *= -1}
	while (place_meeting(x+xadd,y,obj_wall)) xadd = approach(xadd,1,0);
	
	//ver
	while (place_meeting(x,y+yadd,obj_floor)) yadd = approach(yadd,1,0);
	
	mask_index = _mask_prev;
}
function afterimage(number,diff=8){
	afterimage_remain = number;
	afterimage_diff = diff;
}
function update_dir(){
	if(input.is_pressed(INPUT.right) and !input.is_pressed(INPUT.left)) dir = 1;
	if(!input.is_pressed(INPUT.right) and input.is_pressed(INPUT.left)) dir = -1;
}
function combo_break(){
	change_state(STATES.teleport);	
	echo_charges_remain -= echo_tp_cost;
	x = tp_x;	
	__grav_mult = 0;
	__done = false;
}