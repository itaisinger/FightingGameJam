// Inherit the parent event
event_inherited();

max_hp *= 0.9;
hp = max_hp;
ground_fric *= 1.3
slide_fric *= 1.8
walkspd = 9;
landing_lag = 3;
jumpforce_y *= 0.9
jumpforce_x *= 1.3
__lag_remain = 0;
dodge_step_max *= 1.3;

name = "MINAMI NO KAZE"
win_sfx = sfx_minami_wins;

states_sprites[STATES.idle]			= spr_knifer_idle;
states_sprites[STATES.jump_squat]	= spr_knifer_jump_squat;
states_sprites[STATES.walk]			= spr_knifer_walk;
states_sprites[STATES.light]		= spr_knifer_light;
states_sprites[STATES.light2]		= spr_knifer_light_2;
states_sprites[STATES.heavy]		= spr_knifer_heavy;
states_sprites[STATES.air]			= spr_knifer_air;
states_sprites[STATES.echo]			= spr_knifer_echo;
states_sprites[STATES.dodge]		= spr_knifer_dodge;
states_sprites[STATES.stun]			= spr_knifer_hurt;
states_sprites[STATES.air_stun]		= spr_knifer_hurt;
states_sprites[STATES.dead]			= spr_knifer_dead;
states_sprites[STATES.parry]		= spr_knifer_parry;
states_sprites[STATES.teleport]		= spr_knifer_tp;
states_sprites[STATES.special]		= spr_knifer_special;
states_sprites[STATES.land]			= spr_knifer_land;
states_sprites[STATES.air_light]	= spr_knifer_air_light;
states_sprites[STATES.air_light2]	= spr_knifer_air_light_2;
states_sprites[STATES.air_heavy]	= spr_knifer_air_heavy;
states_sprites[STATES.air_special]	= spr_knifer_air_special;

hurtbox = spr_knifer_idle;
//states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= hurtbox_knifer_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_knifer_jump_squat;
//states_hurtboxes[STATES.walk]		= hurtbox_knifer_walk;
states_hurtboxes[STATES.light]		= hurtbox_knifer_light;
states_hurtboxes[STATES.light2]		= hurtbox_knifer_idle;
states_hurtboxes[STATES.heavy]		= hurtbox_knifer_heavy;
states_hurtboxes[STATES.air]		= hurtbox_knifer_air;
states_hurtboxes[STATES.echo]		= hurtbox_knifer_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_knifer_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_knifer_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_knifer_hurt;
//states_hurtboxes[STATES.dead]		= hurtbox_knifer_dead;
states_hurtboxes[STATES.parry]		= hurtbox_knifer_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_knifer_tp;
states_hurtboxes[STATES.special]	= hurtbox_knifer_special;
states_hurtboxes[STATES.land]		= hurtbox_knifer_land;
states_hurtboxes[STATES.air_light]	= hurtbox_knifer_air_light;
states_hurtboxes[STATES.air_light2]	= hurtbox_knifer_air_light_2;
states_hurtboxes[STATES.air_heavy]	= hurtbox_knifer_air_heavy;
states_hurtboxes[STATES.air_special]= hurtbox_knifer_air_special;

image_xscale = 1;
image_yscale = 1;

hitbox_data[STATES.light]		= new HitboxData(hitbox_knifer_light,3,25,5,5,3,0,0,false);
hitbox_data[STATES.light2]		= new HitboxData(hitbox_knifer_light_2,6,45,5,1,8,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_knifer_heavy,9,100,4,8,5,0,1,false);
hitbox_data[STATES.special]		= new HitboxData(hitbox_knifer_special,2,20,7,3,3,0,0,false,,1);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_knifer_air_light,4,40,5,3,4,0,0,false,	function(){yadd = -4});
hitbox_data[STATES.air_light2]	= new HitboxData(hitbox_knifer_air_light_2,3,30,5,3,4,0,0,false,function(){yadd = -4});
hitbox_data[STATES.air_heavy]	= new HitboxData(hitbox_knifer_air_heavy,4,80,10,5,5,0,0,false,,1.2);
hitbox_data[STATES.air_special]	= new HitboxData(hitbox_knifer_air_special,3,15,4,1,3,0,0,false,,1);
hitbox_data[STATES.air_special2]= new HitboxData(hitbox_knifer_air_special,8,35,7,-8.5,6,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_knifer_parry,1,100,180,3,3,1,false,true);

function create_butterflies(margin){
	for(var xx=bbox_left; xx <= bbox_right; xx += margin)
	{
		for(var yy=bbox_top; yy <= bbox_bottom; yy += margin)
		{
			var _inst = instance_create_depth(xx,yy,depth-1,obj_butterfly);
			_inst.dir = xx >= x ? 1 : -1;
			_inst._create(self);
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
		teleport(70);
		change_state(STATES.light2);
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
	
	if(reached_frame(2)){
		update_dir();
		teleport(400);
		image_index++;
	}
	
	//trans out
	if(reached_frame(4) and !(input.is_pressed(INPUT.light_down) or input.is_pressed(INPUT.heavy_down)))
		change_state(STATES.idle);
	
	//start spin
	if(reached_frame(5)) afterimage(6,15);
	
	//hitbox 2,3
	if(reached_frame(6) or reached_frame(7))
	{
		create_hitbox(hitbox_data[STATES.special]);
	}
	
	//slide while spinning
	if(image_index >= 5)
	{
		update_dir();
		xadd = 7 * dir * __move_mult;
	}
	
	//stop or loop
	if(anim_done){
		
		if(input.is_pressed(INPUT.light_down) or input.is_pressed(INPUT.heavy_down)) and __move_mult > 0.2{
			image_index = 5;
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
	
	////consume charge
	//if(state_changed)
	//	echo_charges_remain--;
	
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
	
	scalex = 1.2;
	scaley = 1.2;
	
	//trans to special
	if(state_count <= special_trans_grace_length and input.is_pressed(INPUT.special))
		change_state(STATES.air_special)
	
	if(reached_frame(1)){
		yadd = min(-4,yadd-4);
		xadd += 1 * dir
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
arr_state_functions[STATES.dead] = function(){
	
	if(state_changed){
		
		//left
		var _inst = instance_create_depth(bbox_left,bbox_bottom,depth,obj_knife);
		_inst.xadd = abs(xadd+2)*-1;
		_inst.yadd = min(yadd*1.3,-3);
		_inst.floor_y = floor_y
		_inst.is_echo = is_echo;
		_inst.dir *= -1;
		_inst.spin_spd *= random_range(0.8,1.2)
		
		//right
		var _inst = instance_create_depth(bbox_right,bbox_top,depth,obj_knife);
		_inst.xadd = abs(xadd+2);
		_inst.yadd = min(yadd*1.3,-3);
		_inst.floor_y = floor_y
		_inst.is_echo = is_echo;
		_inst.spin_spd *= random_range(0.8,1.2)
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
arr_state_functions[STATES.air_heavy] = function(){
	
	//scalex = 0.9;
	//scaley = 0.9;
	
	if(state_changed)
	{
		yadd = -jumpforce_y/2;
		xadd -= 4*dir;
	}
	
	xadd = approach(xadd,air_fric*0.5,0);
	yadd += grav*0.9;
	
	if(reached_frame(2))
	{
		yadd = -jumpforce_y/2;
		xadd = 9*dir
	}
	
	if(floor(image_index) != floor(image_index_prev) and image_index < 5)// and floor(image_index)%2 == 0)
	{
		create_hitbox(hitbox_data[STATES.air_heavy]);
		inst_hitbox.image_index = image_index;
	}
	
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
arr_state_functions[STATES.air_special] = function(){
	
	if(state_changed){
		yadd -= 1;
	}
	
	if(reached_frame(2))
	{
		update_dir();
		teleport(0,floor_y-y)
		image_index++;
		xadd *= 0.1;
	}
	
	if(reached_frame(6) or reached_frame(9))
	{
		create_hitbox(hitbox_data[STATES.air_special]);
		xadd += 5 * dir;
	}
	
	if(reached_frame(12))
	{
		create_hitbox(hitbox_data[STATES.air_special2]);
		xadd -= 8 * dir;
	}
	
	if(image_index <= 4)
	{
		yadd += grav * 0.8;
		xadd = approach(xadd,air_fric*0.7,0);
	}
	else
	{
		yadd += grav;
		xadd = approach(xadd,slide_fric*0.5,0);
	}

	//done		
	if(anim_done)
		change_state(STATES.idle);
}
arr_state_functions[STATES.walk] = function(){
	
	scalex = 0.9;
	scaley = 0.8;
	shadow_w = 1.4;
	
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
	if(input.is_pressed(INPUT.echo) and echo_saved == -1)
		change_state(STATES.echo);
		
	
	//light
	if(input.is_pressed(INPUT.light)) change_state(STATES.light);
	
	//heavy
	if(input.is_pressed(INPUT.heavy)) change_state(STATES.heavy);

	//special
	if(input.is_pressed(INPUT.special)) change_state(STATES.special);
}