event_inherited();

/// TOP LOGIC
is_echo = false;
max_hp *= 1.2;
hp = max_hp;
dir = 1;
echo_charges_max = 3;
echo_charges_remain = echo_charges_max;
hitpause_remain = 0;
is_p1 = true;

name = "JOSHUA"
win_sfx = sfx_jhoshua_wins;

/// MOVEMENT
xadd = 0;
yadd = 0;
walkspd = 7;
grav = 0.6;
stun_grav = grav * 0.4;
air_drift_spd = walkspd*0.03;
max_air_spd = walkspd * 1.5;
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

stun_remain = 0;

/// INPUT
input = -1;		//holds the input object for the current frame.

/// ANIMATION AND VISUALS
anim_done = false;
image_speed_prev = 1;
image_index_prev = 0;
_xshake = 0;
_yshake = 0;
floor_y = -100;
depth = DEPTH.player;

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
states_sprites[STATES.air_stun]		= spr_fighter_air_hurt;
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
states_hurtboxes[STATES.air_stun]	= hurtbox_fighter_air_hurt;
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
hitbox_data[STATES.light]		= new HitboxData(hitbox_fighter_light,4,45,5,3,4,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_fighter_heavy,8,100,15,5,9,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_fighter_special,12,60,10,7,5,1,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_air_light,5,60,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_fighter_air_heavy,10,90,10,3,5,0,0,false);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_fighter_air_special,4,20,5,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_fighter_parry,1,100,180,3,3,1,false,true);
inst_hitbox = noone;	//saves the currently active hitbox.


var names = variable_instance_get_names(id);
for(var i = 0; i < array_length(names); i++){
    var val = variable_instance_get(id, names[i]);
    if(is_method(val))
        variable_instance_set(id, names[i], method(id, val));
}
for(var i=0; i < STATES.max; i++){
	if(is_method(arr_state_functions[i])) 
		arr_state_functions[i] = method(self,arr_state_functions[i])
}


//state functions
arr_state_functions[STATES.light] = function(){
	
	if(state_changed){
		xadd += dir * 0.0;
	}
	
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	//link to heavy
	if(image_index >= 2 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.heavy);
		image_index++;
		xadd += 3 * dir;
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
	
	if(is_hit_success() and input.is_pressed(INPUT.up)){
		change_state(STATES.jump_squat);
		image_index += 0.5;
	}
		
	
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
arr_state_functions[STATES.special] = function()
{
	xadd = approach(xadd,ground_fric*1.2,0);
	yadd = 0;
	
	if(reached_frame(3)){
		xadd = 30 * dir;
		afterimage(4,3);
	}
	
	if(anim_done){
		change_state(STATES.idle);
	}
}
arr_state_functions[STATES.air_light] = function(){
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	
	if(reached_frame(2))
	{
		xadd += dir * jumpforce_x * 0.7;
		yadd -= jumpforce_y/2;
	}
	
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
