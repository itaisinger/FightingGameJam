// Inherit the parent event
event_inherited();

max_hp *= 0.8;
hp = max_hp;
ground_fric *= 0.1
slide_fric *= 0.5
walkspd = 8;
accel = 1;
landing_lag = 12;

name = "JOHNNY DREX"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_skate_idle;
states_sprites[STATES.jump_squat]	= spr_skate_jump_squat;
states_sprites[STATES.walk]			= spr_skate_walk;
states_sprites[STATES.light]		= spr_skate_light;
states_sprites[STATES.heavy]		= spr_skate_heavy;
states_sprites[STATES.air]			= spr_skate_air;
states_sprites[STATES.echo]			= spr_skate_echo;
states_sprites[STATES.dodge]		= spr_skate_dodge;
states_sprites[STATES.stun]			= spr_skater_hurt;
states_sprites[STATES.air_stun]		= spr_skater_hurt;
states_sprites[STATES.dead]			= spr_fighter_dead;
states_sprites[STATES.parry]		= spr_skate_parry;
states_sprites[STATES.teleport]		= spr_skater_tp;
states_sprites[STATES.special]		= spr_skate_special;
states_sprites[STATES.land]			= spr_skate_land;
states_sprites[STATES.air_light]	= spr_skate_air_light;
states_sprites[STATES.air_heavy]	= spr_skate_air_heavy;
states_sprites[STATES.air_special]	= spr_skate_air_special;

hurtbox = hurtbox_skate_idle;
states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_skate_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_skate_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
states_hurtboxes[STATES.light]		= hurtbox_skate_light;
states_hurtboxes[STATES.heavy]		= hurtbox_skate_heavy;
states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
states_hurtboxes[STATES.echo]		= hurtbox_skate_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_skate_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_skater_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_skater_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_fighter_dead;
states_hurtboxes[STATES.parry]		= hurtbox_skate_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
states_hurtboxes[STATES.special]	= hurtbox_skate_special;
states_hurtboxes[STATES.land]		= hurtbox_skate_land;
states_hurtboxes[STATES.air_light]	= hurtbox_skate_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_skate_air_heavy;
states_hurtboxes[STATES.air_special]= hurtbox_skate_air_special;

pogo = function(){yadd = -jumpforce_y*0.7}

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
hitbox_data[STATES.light]		= new HitboxData(hitbox_skate_light,2,25,5,3,5,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_skate_heavy,8,80,15,6,9,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_skate_special,8,40,10,12,7,0,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_skate_air_light,4,25,5,3,7,0,0,false,pogo);
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_skate_air_heavy,12,40,10,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_skate_parry,1,30,130,3,5,1,0,true);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_skate_air_special,1.4,10,20,5,5,0,1,false,,1.2);

arr_state_functions[STATES.idle] = function(){
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	sprite_index = xadd != 0 ? spr_skate_slide : spr_skate_idle;
	
	//fall failsafe
	if(!is_grounded())
		change_state(STATES.air);
	
	//stop
	if(input.is_pressed(INPUT.down)){
		xadd = approach(xadd,ground_fric*2,0);
		sprite_index = spr_skate_idle
	}

	
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
	if(input.is_pressed(INPUT.echo) and echo_saved == -1)
		change_state(STATES.echo);
}
arr_state_functions[STATES.walk] = function(){
	
	yadd = 0;
	xadd_dest = dir * walkspd;
	
	//if moving fast, slow down. otherwise, snap to speed
	if(abs(xadd) < abs(xadd_dest)) xadd = approach(xadd,accel,xadd_dest);
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
	if(input.is_pressed(INPUT.echo) and echo_saved == -1)
			change_state(STATES.echo);
			
	//light
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//special
	if(input.is_pressed(INPUT.special)) change_state(STATES.special);
}
arr_state_functions[STATES.air_light] = function(){
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	//link to heavy
	if(image_index >= 2 and input.is_pressed(INPUT.heavy))
		change_state(STATES.air_heavy);
	
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
arr_state_functions[STATES.special] = function()
{
	xadd = approach(xadd,ground_fric*1.5,0);
	yadd = 0;
	
	if(reached_frame(2)) xadd *= 0.4;
	
	if(reached_frame(3)){
		xadd = 15 * dir;
	}
	
	if(is_hit_success() and input.is_pressed(INPUT.up))
		change_state(STATES.jump_squat);
	
	if(anim_done){
		change_state(STATES.idle);
	}
}
arr_state_functions[STATES.air_special] = function(){
	
	if(state_changed)
	{
		__grav_mult = 0.2;
		__grav_multx = 1;
		yadd = 0;
	}
	
	//start spin
	if(reached_frame(10))
	{
		__grav_mult = 0;
		yadd = 0;
		__grav_multx = 0;
		xadd = dir * 8;
	}
	
	//end spin
	if(reached_frame(18))
	{
		__grav_mult = 0.5;
		__grav_multx = 1;
	}
	
	if(floor(image_index) != floor(image_index_prev))// and floor(image_index)%2 == 0)
	{
		create_hitbox(hitbox_data[STATES.air_special]);
		inst_hitbox.image_index = image_index;
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
		
		//jump
		if(input.is_pressed(INPUT.up)) change_state(STATES.jump_squat);
	}
	
	//done
	if(anim_done)
		change_state(STATES.idle);
	
}
arr_state_functions[STATES.teleport] = function()
{
	if(state_changed){
		__grav_mult = 0.5;
		yadd = -jumpforce_y/2;
	}
	
	yadd = approach(yadd,grav * __grav_mult,0);
	xadd = 0;
	
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
arr_state_functions[STATES.dead] = function(){
	
	if(state_changed){
		var _inst = instance_create_depth((bbox_right+bbox_left)/2,(bbox_top+bbox_bottom)/2,depth,obj_skateboard);
		_inst.xadd = xadd*2;
		_inst.yadd = min(yadd*2,-5);
		_inst.floor_y = floor_y
		_inst.is_echo = is_echo;
	}
	
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
	
	xadd = approach(xadd,slide_fric,0);
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
	if(place_meeting(x+xadd,y,obj_wall) and state == STATES.air_stun){ xadd *= - 1; dir *= -1}
	if(place_meeting(x+xadd,y,obj_wall) and state == STATES.idle){ xadd *= -0.7; dir *= -1}
	while (place_meeting(x+xadd,y,obj_wall)) xadd = approach(xadd,1,0);
	
	//ver
	while (place_meeting(x,y+yadd,obj_floor)) yadd = approach(yadd,1,0);
	
	mask_index = _mask_prev;
}