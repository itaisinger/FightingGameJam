// Inherit the parent event
event_inherited();

name = "SHON SHMUPS"
win_sfx = sfx_shon_wins;
max_hp = 100;
hp = max_hp;

states_sprites[STATES.idle]			= spr_shooter_idle;
states_sprites[STATES.jump_squat]	= spr_shooter_jump_squat;
states_sprites[STATES.walk]			= spr_shooter_walk;
states_sprites[STATES.light]		= spr_shooter_light;
states_sprites[STATES.heavy]		= spr_shooter_heavy;
states_sprites[STATES.air]			= spr_shooter_air;
states_sprites[STATES.echo]			= spr_shooter_echo;
states_sprites[STATES.dodge]		= spr_shooter_dodge;
states_sprites[STATES.stun]			= spr_shooter_hurt;
states_sprites[STATES.air_stun]		= spr_shooter_hurt;
states_sprites[STATES.dead]			= spr_shooter_death;
states_sprites[STATES.parry]		= spr_shooter_parry;
states_sprites[STATES.teleport]		= spr_shooter_teleport;
states_sprites[STATES.special]		= spr_shooter_special;
states_sprites[STATES.land]			= spr_shooter_land;
states_sprites[STATES.air_light]	= spr_shooter_air_light;
states_sprites[STATES.air_heavy]	= spr_shooter_air_heavy;
states_sprites[STATES.air_special]	= spr_shooter_air_special;

hurtbox = hurtbox_shooter_idle;
states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_shooter_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_shooter_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_shooter_walk;
states_hurtboxes[STATES.light]		= hurtbox_shooter_light;
states_hurtboxes[STATES.heavy]		= hurtbox_shooter_heavy;
states_hurtboxes[STATES.air]		= hurtbox_shooter_air;
states_hurtboxes[STATES.echo]		= hurtbox_shooter_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_shooter_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_shooter_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_shooter_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_shooter_hurt;
states_hurtboxes[STATES.parry]		= hurtbox_shooter_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_shooter_hurt;
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
hitbox_data[STATES.parry]		= new HitboxData(hitbox_shooter_parry,1,20,130,3,5,0,0,true);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_shooter_air_special,3,20,20,3,5,0,1,false);




//////// overrides
arr_state_functions[STATES.air_heavy] = function(){

	if(state_changed){
		__grav_mult = 0.5;	
		yadd -= 3;
	}
	
	if(reached_frame(3))
	{
		__grav_mult = 1;
		xadd = -dir * 7;
		yadd = -7;
	}
	
		
	
	yadd += grav * __grav_mult;
	xadd = approach(xadd,air_fric,0);
	
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
		
	xadd = approach(xadd,slide_fric*0.5,0);
	yadd = 0;
	
	if(state_changed)
		xadd = 15 * dir;
	
	if(anim_done){
		change_state(STATES.idle);
	}
}
arr_state_functions[STATES.dead] = function(){
	
	if(state_changed) __created = false;
	
	if(reached_frame(4) and !__created){
		mask_index = spr_shooter_death;
		var _inst = instance_create_depth(bbox_left,bbox_top,depth,obj_shooter_eye);
		_inst.xadd = -5;
		_inst.yadd = min(yadd*8,-3);
		_inst.floor_y = floor_y
		
		var _inst = instance_create_depth(bbox_right,bbox_bottom,depth,obj_shooter_shield);
		_inst.xadd = 5;
		_inst.yadd = min(yadd*4,-2);
		_inst.floor_y = floor_y
		
		image_speed = 0;
		image_index++;
		disable_draw = true;
		__created = true;
	}
	
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
}