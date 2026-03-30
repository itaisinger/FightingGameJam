// Inherit the parent event
event_inherited();

max_hp = 80;
hp = max_hp;
ground_fric *= 1.3
slide_fric *= 1.8
walkspd = 9;
landing_lag = 3;
jumpforce_y *= 0.9
jumpforce_x *= 1.3
__lag_remain = 0;

name = "MINAMI NO KAZE"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_knifer_idle;
states_sprites[STATES.jump_squat]	= spr_knifer_jump_squat;
//states_sprites[STATES.walk]			= spr_knifer_walk;
states_sprites[STATES.light]		= spr_knifer_light;
states_sprites[STATES.light2]		= spr_knifer_light_2;
states_sprites[STATES.heavy]		= spr_knifer_heavy;
states_sprites[STATES.air]			= spr_knifer_air;
states_sprites[STATES.echo]			= spr_knifer_echo;
//states_sprites[STATES.dodge]		= spr_knifer_dodge;
states_sprites[STATES.stun]			= spr_knifer_hurt;
states_sprites[STATES.air_stun]		= spr_knifer_hurt;
//states_sprites[STATES.dead]		= spr_fighter_dead;
//states_sprites[STATES.parry]		= spr_knifer_parry;
states_sprites[STATES.teleport]		= spr_knifer_tp;
states_sprites[STATES.special]		= spr_knifer_special;
states_sprites[STATES.land]			= spr_knifer_land;
states_sprites[STATES.air_light]	= spr_knifer_air_light;
states_sprites[STATES.air_light2]	= spr_knifer_air_light_2;
//states_sprites[STATES.air_heavy]	= spr_knifer_air_heavy;
//states_sprites[STATES.air_special]	= spr_knifer_air_special;

hurtbox = spr_knifer_idle;
//states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_knifer_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_knifer_jump_squat;
//states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
states_hurtboxes[STATES.light]		= hurtbox_knifer_light;
states_hurtboxes[STATES.light2]		= hurtbox_knifer_idle;
states_hurtboxes[STATES.heavy]		= hurtbox_knifer_heavy;
states_hurtboxes[STATES.air]		= hurtbox_knifer_air;
states_hurtboxes[STATES.echo]		= hurtbox_knifer_echo;
//states_hurtboxes[STATES.dodge]		= hurtbox_knifer_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_knifer_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_knifer_hurt;
//states_hurtboxes[STATES.dead]		= hurtbox_fighter_dead;
//states_hurtboxes[STATES.parry]		= hurtbox_knifer_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
states_hurtboxes[STATES.special]	= hurtbox_knifer_special;
states_hurtboxes[STATES.land]		= hurtbox_knifer_land;
states_hurtboxes[STATES.air_light]	= hurtbox_knifer_air_light;
states_hurtboxes[STATES.air_light2]	= hurtbox_knifer_air_light_2;
//states_hurtboxes[STATES.air_heavy]	= hurtbox_knifer_air_heavy;
//states_hurtboxes[STATES.air_special]= hurtbox_knifer_air_special;

image_xscale = 1;
image_yscale = 1;

hitbox_data[STATES.light]		= new HitboxData(hitbox_knifer_light,2,25,5,5,3,0,0,false);
hitbox_data[STATES.light2]		= new HitboxData(hitbox_knifer_light_2,6,45,5,1,8,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_knifer_heavy,8,100,4,8,5,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_knifer_special,3,20,7,5,5,0,0,false,,1);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_fighter_air_light,4,40,5,3,4,0,0,false,function(){yadd-=4});
hitbox_data[STATES.air_light2]	= new HitboxData(hitbox_fighter_air_light,3,30,5,3,4,0,0,false,function(){yadd-=4});
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_fighter_air_heavy,10,90,10,3,5,0,0,false);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_fighter_air_special,4,20,5,3,5,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_fighter_parry,1,180,20,3,3,1,false,true);

function create_butterflies(margin){
	for(var xx=bbox_left; xx <= bbox_right; xx += margin)
	{
		for(var yy=bbox_top; yy <= bbox_bottom; yy += margin)
		{
			var _inst = instance_create_depth(xx,yy,depth-1,obj_butterfly);
			_inst.dir = xx >= x ? 1 : -1;
			_inst._create();
		}
	}
}
function teleport(deltax,deltay=0)
{
	var _mask_prev = mask_index;
	mask_index = sprite_index;
	var _shift = dir;
	//if(input.is_pressed(INPUT.right) and !input.is_pressed(INPUT.left)) _shift += 0.5;
	//if(!input.is_pressed(INPUT.right) and input.is_pressed(INPUT.left)) _shift -= 0.5;
	
	deltax *= _shift
	
	create_butterflies(3);
	
	//move
	var _prev = [xadd,yadd];
	xadd = deltax;
	yadd = deltay;
	
	collision();
	
	x += xadd;
	y += yadd;
	
	xadd = _prev[0];
	yadd = _prev[1];
	
	//butterflies
	create_butterflies(15);
	
	mask_index = _mask_prev;
}
function combo_break(){
	change_state(STATES.teleport);	
	echo_charges_remain -= echo_tp_cost;
	create_butterflies(2);
	x = tp_x;	
	__grav_mult = 0;
	__done = false;
}

arr_state_functions[STATES.light] = function(){
	
	if(state_changed) xadd -= dir * 4;
	
	if(reached_frame(1)){
		xadd += dir * 22
	}
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	//link to light 2
	if(image_index >= 2 and input.is_pressed(INPUT.light)){
		change_state(STATES.light2);
		teleport(70);
	}
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.light2] = function(){
	
	if(reached_frame(1)){
		xadd += dir * 6
	}
	
	xadd = approach(xadd,ground_fric,0);
	yadd = 0;
	
	//link to heavy?
	if(image_index >= 2 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.heavy);
	}
	
	if(anim_done)
		change_state(STATES.idle)
}
arr_state_functions[STATES.heavy] = function(){
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	if(reached_frame(4)){
		teleport(0,-120);
		image_index++;
	}
	if(image_index >= 6){
		xadd = dir * 14;
		yadd = 6;
		
		if(is_grounded())
			change_state(STATES.idle);
	}
	else
	{
		xadd = approach(xadd,ground_fric,0);
		yadd = 0;
	}
	
	if(anim_done)
		change_state(is_grounded() ? STATES.idle : STATES.air);
}
arr_state_functions[STATES.special] = function(){
	
	if(state_changed) __move_mult = 1;
	
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(reached_frame(4)){
		update_dir();
		teleport(400);
		image_index++;
	}
	
	//trans out
	if(reached_frame(6) and !(input.is_pressed(INPUT.light_down) or input.is_pressed(INPUT.heavy_down)))
		change_state(STATES.idle);
	
	//start spin
	if(reached_frame(7)) afterimage(6,15);
	
	//hitbox 2,3
	if(reached_frame(8) or reached_frame(9))
	{
		create_hitbox(hitbox_data[STATES.special]);
	}
	
	
	//slide while spinning
	if(image_index >= 7)
	{
		update_dir();
		xadd = 6 * dir * __move_mult;
	}
	
	//stop or loop
	if(anim_done){
		
		if(input.is_pressed(INPUT.light_down) or input.is_pressed(INPUT.heavy_down)) and __move_mult > 0.2{
			image_index = 7;
			__move_mult = approach(__move_mult,0.2,0);
			afterimage(floor(6 * __move_mult) ,15 * floor(map_value(1-__move_mult,0,1,1,2)))
			image_speed *= 0.7;
			create_hitbox(hitbox_data[STATES.special]);
		}
		else{
			__lag_remain = map_value(1-__move_mult,0,1, 10,40);
			xadd = 12 * dir;
			change_state(STATES.land)
		}
	}
}
arr_state_functions[STATES.land] = function(){
	
	yadd = 0;
	xadd = approach(xadd,slide_fric,0);
	
	if(state_count < __lag_remain) return;
	else __lag_remain = -1;
	
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
arr_state_functions[STATES.teleport] = function()
{
	if(state_changed){
		create_butterflies(10);
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
		if(input.is_pressed(INPUT.heavy))
			change_state(STATES.air_heavy);
		
		//special
		if(input.is_pressed(INPUT.special))
			change_state(STATES.air_special);
		
		if(anim_done)
			change_state(STATES.air);
		
		//land
		if(is_grounded())
			change_state(STATES.idle)
	}
}
arr_state_functions[STATES.echo] = function(){
	
	//consume charge
	if(state_changed)
		echo_charges_remain--;
	
	yadd = 0;
	xadd = approach(xadd,slide_fric,0)
	
	//if(reached_frame(5))
	//	create_butterflies(4)
	
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
arr_state_functions[STATES.air_light] = function(){
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	if(reached_frame(1)){
		yadd = min(-5,yadd-5);
		xadd += 3 * dir
	}
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;

	//link to heavy
	if(image_index >= 2 and input.is_pressed(INPUT.heavy)){
		change_state(STATES.air_heavy);
		image_index += 1;
	}
	
	//link to light 2
	if(image_index >= 2 and input.is_pressed(INPUT.light)){
		change_state(STATES.air_light2);
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
arr_state_functions[STATES.air_light2] = function(){
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	
	if(reached_frame(1)){
		yadd = min(-3,yadd-3);
		xadd += 3 * dir
	}
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav*0.8;
	
	////link to heavy
	//if(image_index >= 2 and input.is_pressed(INPUT.heavy)){
	//	change_state(STATES.air_heavy);
	//	image_index += 1;
	//}
	
	if(reached_frame(3))
		create_hitbox(hitbox_data[STATES.air_light2]);
		
	if(reached_frame(4))
	{
		yadd = min(-4,yadd-4);
		xadd += 3 * dir
		//with(inst_hitbox) arr_hits = [];
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