// Inherit the parent event
event_inherited();

name = "SHON SHMUPS"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_shooter_idle;
states_sprites[STATES.jump_squat]	= spr_shooter_jump_squat;
states_sprites[STATES.walk]			= spr_shooter_walk;
states_sprites[STATES.light]		= spr_shooter_light;
states_sprites[STATES.heavy]		= spr_shooter_heavy;
states_sprites[STATES.air]			= spr_shooter_air;
states_sprites[STATES.echo]			= spr_shooter_echo;
states_sprites[STATES.dodge]		= spr_shooter_dodge;
states_sprites[STATES.stun]			= spr_fighter_hurt;
states_sprites[STATES.air_stun]		= spr_fighter_hurt;
states_sprites[STATES.dead]			= spr_fighter_dead;
states_sprites[STATES.parry]		= spr_shooter_parry;
states_sprites[STATES.teleport]		= spr_fighter_tp;
states_sprites[STATES.special]		= spr_shooter_special;
states_sprites[STATES.land]			= spr_shooter_land;
states_sprites[STATES.air_light]	= spr_shooter_air_light;
states_sprites[STATES.air_heavy]	= spr_shooter_air_heavy;
states_sprites[STATES.air_special]	= spr_shooter_air_special;

hurtbox = hurtbox_shooter_idle;
states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_shooter_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_shooter_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
states_hurtboxes[STATES.light]		= hurtbox_shooter_light;
states_hurtboxes[STATES.heavy]		= hurtbox_shooter_heavy;
states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
states_hurtboxes[STATES.echo]		= hurtbox_shooter_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_shooter_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_fighter_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_fighter_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_fighter_hurt;
states_hurtboxes[STATES.parry]		= hurtbox_shooter_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
states_hurtboxes[STATES.special]	= hurtbox_shooter_special;
states_hurtboxes[STATES.land]		= hurtbox_shooter_land;
states_hurtboxes[STATES.air_light]	= hurtbox_shooter_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_shooter_air_heavy;
states_hurtboxes[STATES.air_special]= hurtbox_shooter_air_special;

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

//data
hitbox_data = array_create(STATES.max,-1)
hitbox_data[STATES.light]		= new HitboxData(hitbox_shooter_light,2,25,5,3,5,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_shooter_heavy,8,80,15,6,9,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_shooter_special,8,40,10,12,7,1,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_shooter_air_light,4,25,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_shooter_air_heavy,12,40,10,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_shooter_parry,1,180,20,3,5,0,0,true);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_shooter_air_special,3,20,20,3,5,0,1,false);




//////// overrides
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
		xadd = dir * 14;
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
		with(inst_hitbox) instance_destroy();
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

arr_state_functions[STATES.special] = function()
{
		
	xadd = approach(xadd,ground_fric*1.2,0);
	yadd = 0;
	xadd = 15* dir;
	
	//	if(reached_frame(1))
	//{
	//	__grav_mult = 0;
	//	xadd = dir * 14;
	//	__grav_multx = 1
	//	yadd = 2;
	//}
	
	//if(reached_frame(1)){
	//	xadd = 30 * dir;
	//}
	
	if(anim_done){
		change_state(STATES.idle);
	}
}