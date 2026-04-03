// Inherit the parent event
event_inherited();

max_hp *= 1.2;
hp = max_hp;

xadd = 0;
yadd = 0;
walkspd = 6.5;
grav = 0.6;
stun_grav = grav * 0.4;
air_drift_spd = walkspd*0.03;
max_air_spd = walkspd * 10;
air_fric = 0.05;
stun_air_fric = air_fric * 0.25;
ground_fric = 1;
slide_fric = ground_fric * 0.4;	//used to slide when entering states that slide

jumpforce_y = 12;
name = "SPYKE"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_spyke_idle;
states_sprites[STATES.jump_squat]	= spr_spyke_jump_squat;
states_sprites[STATES.walk]			= spr_spyke_walk;
states_sprites[STATES.light]		= spr_spyke_light;
states_sprites[STATES.heavy]		= spr_spyke_heavy;
states_sprites[STATES.air]			= spr_spyke_air;
states_sprites[STATES.echo]			= spr_spyke_echo;
states_sprites[STATES.dodge]		= spr_spyke_dodge;
states_sprites[STATES.stun]			= spr_spyke_hurt;
states_sprites[STATES.air_stun]		= spr_spyke_hurt;
states_sprites[STATES.dead]			= spr_fighter_dead;
states_sprites[STATES.parry]		= spr_spyke_parry;
states_sprites[STATES.teleport]		= spr_spyke_teleport;
states_sprites[STATES.special]		= spr_spyke_special;
states_sprites[STATES.land]			= spr_spyke_land;
states_sprites[STATES.air_light]	= spr_spyke_air_light;
states_sprites[STATES.air_heavy]	= spr_spyke_air_heavy;
states_sprites[STATES.air_special]	= spr_spyke_air_special;

hurtbox = hurtbox_spyke_idle;
//states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_spyke_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_spyke_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_spyke_walk;
states_hurtboxes[STATES.light]		= hurtbox_spyke_light;
states_hurtboxes[STATES.heavy]		= hurtbox_spyke_heavy;
states_hurtboxes[STATES.air]		= hurtbox_spyke_air;
states_hurtboxes[STATES.echo]		= hurtbox_spyke_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_spyke_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_spyke_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_spyke_hurt;
//states_hurtboxes[STATES.dead]		= hurtbox_spyke_dead;
states_hurtboxes[STATES.parry]		= hurtbox_spyke_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_spyke_teleport;
states_hurtboxes[STATES.special]	= hurtbox_spyke_special;
states_hurtboxes[STATES.land]		= hurtbox_spyke_land;
states_hurtboxes[STATES.air_light]	= hurtbox_spyke_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_spyke_air_heavy;
states_hurtboxes[STATES.air_special]= hurtbox_spyke_air_special;

hitbox_data = array_create(STATES.max,-1)
hitbox_data[STATES.light]		= new HitboxData(hitbox_spyke_light,3,45,5,1,6,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_spyke_heavy,8,70,15,2,10,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_spyke_special,9,60,10,7,5,0,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_spyke_air_light,5,60,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_spyke_air_heavy,8,90,10,3,1,0,0,false);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_spyke_air_special,4,20,5,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_spyke_parry,1,100,180,3,3,1,false,true);

// Moves ovveride
arr_state_functions[STATES.air_special] = function(){
	
	if(state_changed)
	{
		__grav_mult = 0;
		__grav_multx = 8;
		yadd = 0;
	}
	
	if(reached_frame(1))
	{
		__grav_mult = 1;
		xadd = dir * 17;
		__grav_multx = 1
		yadd = 2;
	}
	
	//if(reached_frame(4))
	//{
	//	create_hitbox(hitbox_data[STATES.air_special]);
	//	inst_hitbox.image_index = image_index;
	//}
	
	//if(reached_frame(5))
	//{
	//	//with(inst_hitbox) instance_destroy();
	//	create_hitbox(hitbox_data[STATES.air_special]);
	//	inst_hitbox.image_index = image_index;
	//}
	
	//if(reached_frame(6)){
	//	__grav_mult = 0.5;
	//}
	
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
arr_state_functions[STATES.special] = function()
{
	xadd = approach(xadd,slide_fric*0.8,0);
	yadd = 0;
	
	
	
	//if(reached_frame(4)){
	//	xadd = 30 * dir;
	//	afterimage(4);
	//}
	
	if(anim_done){
		change_state(STATES.idle);
	}
}
arr_state_functions[STATES.teleport] = function()
{
	if(state_changed){
		__grav_mult = 0;
		__done = false;
	}
	
	if(reached_frame(1))
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
	if(image_index >= 3 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.heavy);
	}
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.air_light] = function(){
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	//link to heavy
	if(image_index >= 4 and input.is_pressed(INPUT.heavy)){
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