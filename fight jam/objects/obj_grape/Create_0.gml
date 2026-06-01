event_inherited();

//STATS
max_hp *= 1.2;
hp = max_hp;
walkspd -= 1.7;
grav *= 0.7;
jumpforce_y *= 1;
jumpforce_x *= 0.7;

name = "GRAPE"
win_sfx = sfx_jhoshua_wins;

states_sprites =array_create(STATES.max,-1);
states_sprites[STATES.idle]			= spr_grape_idle;
states_sprites[STATES.jump_squat]	= spr_grape_jump_squat;
states_sprites[STATES.walk]			= spr_grape_walk;
states_sprites[STATES.light]		= spr_grape_light;
states_sprites[STATES.heavy]		= spr_grape_heavy;
states_sprites[STATES.air]			= spr_grape_air;
states_sprites[STATES.echo]			= spr_grape_echo;
states_sprites[STATES.dodge]		= spr_grape_dodge;
states_sprites[STATES.stun]			= spr_grape_hurt;
states_sprites[STATES.air_stun]		= spr_grape_hurt;
states_sprites[STATES.dead]			= spr_grape_dead;
states_sprites[STATES.parry]		= spr_grape_parry;
states_sprites[STATES.teleport]		= spr_grape_tp;
states_sprites[STATES.special]		= spr_grape_special;
states_sprites[STATES.land]			= spr_grape_land;
states_sprites[STATES.air_light]	= spr_grape_air_light;
states_sprites[STATES.air_heavy]	= spr_grape_air_heavy_start;
states_sprites[STATES.air_heavy2]	= spr_grape_air_heavy2;
states_sprites[STATES.air_heavy3]	= spr_grape_air_heavy3;
states_sprites[STATES.air_special]	= spr_grape_special;
states_sprites[STATES.left]			= spr_grape_sign_left;
states_sprites[STATES.right]		= spr_grape_sign_right;
states_sprites[STATES.up]			= spr_grape_sign_up;
states_sprites[STATES.down]			= spr_grape_sign_down;

hurtbox = hurtbox_grape_idle;
states_hurtboxes =array_create(STATES.max,-1);
states_hurtboxes[STATES.idle]		= hurtbox_grape_idle;
states_hurtboxes[STATES.jump_squat]	= hurtbox_grape_jump_squat;
states_hurtboxes[STATES.walk]		= hurtbox_grape_walk;
states_hurtboxes[STATES.light]		= hurtbox_grape_light;
states_hurtboxes[STATES.heavy]		= hurtbox_grape_heavy;
states_hurtboxes[STATES.air]		= hurtbox_grape_air;
states_hurtboxes[STATES.echo]		= hurtbox_grape_echo;
states_hurtboxes[STATES.dodge]		= hurtbox_grape_dodge;
states_hurtboxes[STATES.stun]		= hurtbox_grape_hurt;
states_hurtboxes[STATES.air_stun]	= hurtbox_grape_hurt;
states_hurtboxes[STATES.dead]		= hurtbox_grape_dead;
states_hurtboxes[STATES.parry]		= hurtbox_grape_parry;
states_hurtboxes[STATES.teleport]	= hurtbox_grape_tp;
states_hurtboxes[STATES.special]	= hurtbox_grape_special;
states_hurtboxes[STATES.land]		= hurtbox_grape_land;
states_hurtboxes[STATES.air_light]	= hurtbox_grape_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_grape_air_heavy_start;
states_hurtboxes[STATES.air_heavy2]	= hurtbox_grape_air_heavy2;
states_hurtboxes[STATES.air_heavy3]	= hurtbox_grape_air_heavy3;
states_hurtboxes[STATES.left]		= hurtbox_grape_idle;
states_hurtboxes[STATES.right]		= hurtbox_grape_idle;
states_hurtboxes[STATES.up]			= hurtbox_grape_idle;
states_hurtboxes[STATES.down]		= hurtbox_grape_idle;
mask_index = spr_grape_idle

/// ATTACKS DATA (overrided in different characters)
hitbox_data = array_create(STATES.max,-1)
hitbox_data[STATES.light]		= new HitboxData(hitbox_grape_light,4,45,5,3,4,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_grape_heavy,8,100,15,5,9,0,1,false);
//hitbox_data[STATES.special]	= new HitboxData(hitbox_grape_special,12,60,10,7,5,1,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_grape_air_light,5,60,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy2]	= new HitboxData(hitbox_grape_air_heavy3,4,30,10,2,5,0,0,false);
hitbox_data[STATES.air_heavy3]	= new HitboxData(hitbox_grape_air_heavy3,4,70,10,4,6,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_grape_parry,1,100,180,3,3,1,false,true);
inst_hitbox = noone;	//saves the currently active hitbox.


//magic
//special moves
//1
states_sprites[STATES.special1]		= spr_grape_special;
states_hurtboxes[STATES.special1]	= hurtbox_grape_special;
//hitbox_data[STATES.special1]		= new HitboxData(hitbox_grape_special,12,60,10,7,5,1,1,false);
//2
states_sprites[STATES.special2]		= spr_grape_special;
states_hurtboxes[STATES.special2]	= hurtbox_grape_special;
//hitbox_data[STATES.special2]		= new HitboxData(hitbox_grape_special,12,60,10,7,5,1,1,false);
//3
states_sprites[STATES.special3]		= spr_grape_special3;
states_hurtboxes[STATES.special3]	= hurtbox_grape_special;
//hitbox_data[STATES.special3]		= new HitboxData(hitbox_grape_special,12,60,10,7,5,1,1,false);
//4
states_sprites[STATES.special4]		= spr_grape_special;
states_hurtboxes[STATES.special4]	= hurtbox_grape_special;
//hitbox_data[STATES.special4]		= new HitboxData(hitbox_grape_special,12,60,10,7,5,1,1,false);

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
	
	if((state_count <= special_trans_grace_length or image_index>=3 ) and input.is_pressed(INPUT.special))
		change_state(STATES.special)
	
	xadd = approach(xadd,slide_fric,0);
	yadd = 0;
	
	if(is_hit_success() and input.is_pressed(INPUT.up)){
		change_state(STATES.jump_squat);
		image_index += 0.5;
	}
		
	if(reached_frame(1) and input.is_pressed(INPUT.special)){
		change_state(STATES.special)
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

lighthit = false
arr_state_functions[STATES.air_light] = function(){
	
	xadd = approach(xadd,air_fric,0);
	yadd += grav;
	if(state_changed){
		lighthit=false
	}
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
	if(is_hit_success() and not lighthit){
		//create_vfx(x,y,vfx_hitmark_blue,dir*-1,RUN_VFX_S,0);
		lighthit=true
	}
}
arr_state_functions[STATES.air_heavy] = function(){
	
	if(state_changed)
	{
		yadd = -4;
		xadd = -2*dir;
	}
	
	//transition to air_special
	if(state_count <= special_trans_grace_length && input.is_pressed(INPUT.special))
	{
		change_state(STATES.air_special);
	}

	yadd += grav;
	xadd = approach(xadd, air_fric, 0);
	
	//continue
	if(anim_done)
	{
		change_state(STATES.air_heavy2);
	}

	if(is_grounded())
	{
		change_state(STATES.land);
	}
}
arr_state_functions[STATES.air_heavy2] = function(){
	if(state_changed)
	{
		_yadd = -grav*1.2;
		yadd = 9;
		xadd = dir * 12;
		__active_remain = 30;
	}
	
	var _m = 1;
	if(input.is_pressed(INPUT.up) and !input.is_pressed(INPUT.down)) _m = 1.2;
	if(!input.is_pressed(INPUT.up) and input.is_pressed(INPUT.down)) _m = 0.8;
	yadd += _yadd * _m;
	
	//end
	if(__active_remain-- <= 0)
	{
		change_state(STATES.air)
	}
	
	//land
	if(is_grounded())
	{
		change_state(STATES.idle);
	}
	
	// air_heavy2
	if(is_hit_success())
	{
		change_state(STATES.air_heavy3);
	}
}
arr_state_functions[STATES.air_heavy3] = function(){
	
	if(state_changed)
	{
		xadd = 6 * dir;
		yadd = 0;
	}
	
	if(anim_done)
		change_state(STATES.air)
	
	if(reached_frame(2) or reached_frame(4))
	{
		create_hitbox(hitbox_data[STATES.air_heavy3]);
	}
	
	//land
	if(is_grounded())
	{
		if is_hit_success()
			change_state(STATES.idle)
		else
			change_state(STATES.land);
	}
}

//arr_state_functions[STATES.air_special] = function(){
	
//	if(state_changed)
//	{
//		__grav_mult = 0;
//		__grav_multx = 8;
//		yadd = 0;
//	}
	
//	if(reached_frame(3))
//	{
//		__grav_mult = 0;
//		xadd = dir * 17;
//		__grav_multx = 1
//		yadd = 2;
//	}
	
//	if(reached_frame(4))
//	{
//		create_hitbox(hitbox_data[STATES.air_special]);
//		inst_hitbox.image_index = image_index;
//	}
	
//	if(reached_frame(5))
//	{
//		//with(inst_hitbox) instance_destroy();
//		create_hitbox(hitbox_data[STATES.air_special]);
//		inst_hitbox.image_index = image_index;
//	}
	
//	if(reached_frame(6)){
//		__grav_mult = 0.5;
//	}
	
//	//jump cancel
//	if(instance_exists(inst_hitbox) and array_length(inst_hitbox.arr_hits) > 0 and input.is_pressed(INPUT.up)){
//		change_state(STATES.air)
//		yadd = -jumpforce_y;
//		xadd = dir * jumpforce_x;
//	}
		
	
//	yadd += grav * __grav_mult;
//	xadd = approach(xadd,air_fric*__grav_multx,0);
	
//	//land
//	if(is_grounded())
//	{
//		if is_hit_success()
//			change_state(STATES.idle)
//		else
//			change_state(STATES.land);
//	}
		
//	if(anim_done)
//		change_state(STATES.air);
//}

arr_state_functions[STATES.special] = function(){
	
	if (image_index <= 1) {
        image_index = 2;
    }


    if (state_changed) {
		special_dir=dir;
        image_index = 0;
        image_speed = 1;
	}

    // when animation reaches the end, loop only the last 2 frames

    xadd = lerp(xadd, 0, 0.06);
    yadd = lerp(yadd, 0, 0.06);
    //yadd = approach(yadd, grav*0.6, 0);
	
	if((input.is_pressed(INPUT.dodge) or input.is_pressed(INPUT.special)) and not state_changed){
		change_state(STATES.air);
	}
    if(input.is_pressed(INPUT.up))
        change_state(STATES.up);

    if(input.is_pressed(INPUT.right))
        change_state(STATES.right);

    if(input.is_pressed(INPUT.down))
        change_state(STATES.down);

    if(input.is_pressed(INPUT.left))
        change_state(STATES.left);
}

arr_state_functions[STATES.air_special]=arr_state_functions[STATES.special];
/////////
arr_state_functions[STATES.special1] = function(){
	dir=special_dir;
	if(state_changed){
		create_projectile(obj_icicle,0, -200);
	}
	change_state(STATES.idle);
}
/////////
arr_state_functions[STATES.special2] = function(){
	dir=special_dir;
		if(state_changed){
		create_projectile(obj_fireball,30, -50);
	}
	change_state(STATES.idle);
}
/////
arr_state_functions[STATES.special3] = function(){
	dir=special_dir;
	if(state_changed){
		yadd-=7;
		xadd+=17*dir;
		create_vfx(x, y, SmokeNDust_1, -dir, 1);
	}
	if(anim_done){
		change_state(STATES.air);
	}
	
}
//////
arr_state_functions[STATES.special4] = function(){
	dir=special_dir;
	if(anim_done)
		change_state(STATES.idle);
}
///////////////////////////////////////////

arr_state_functions[STATES.left] = function(){
	xadd = approach(xadd, ground_fric, 0);
    yadd = 0;
		if(state_changed){add_state(); }
	if(anim_done){
		
		image_index = 2
		image_speed=0
	}
	if(image_index >= 2){
		if(handle_array()){return;}
		if(input.is_just_pressed(INPUT.right)){restart_state(STATES.right);image_index = 0 ; anim_done=false;}
		if(input.is_just_pressed(INPUT.left)){ restart_state(STATES.left); image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.up)){ restart_state(STATES.up);image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.down)) {restart_state(STATES.down);image_index = 0; anim_done=false;}
	}
	

}

/////////
arr_state_functions[STATES.right] = function(){
	xadd = approach(xadd, ground_fric, 0);
    yadd = 0;
	if(state_changed){add_state(); }
	if(anim_done){
		
		image_index = 2
		image_speed=0
	}
	if(image_index >= 2){
		if(handle_array()){return;}
		if(input.is_just_pressed(INPUT.right)){restart_state(STATES.right);image_index = 0 ; anim_done=false;}
		if(input.is_just_pressed(INPUT.left)){ restart_state(STATES.left); image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.up)){ restart_state(STATES.up);image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.down)) {restart_state(STATES.down);image_index = 0; anim_done=false;}
	}
	
}
////////////////////
arr_state_functions[STATES.up] = function(){
	xadd = approach(xadd, ground_fric, 0);
    yadd = 0;
	if(state_changed){add_state(); }
	if(anim_done){
		
		image_index = 2
		image_speed=0
		}
		if(image_index >= 2){
			if(handle_array()){return;}
		if(input.is_just_pressed(INPUT.right)){restart_state(STATES.right);image_index = 0 ; anim_done=false;}
		if(input.is_just_pressed(INPUT.left)){ restart_state(STATES.left); image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.up)){ restart_state(STATES.up);image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.down)) {restart_state(STATES.down);image_index = 0; anim_done=false;}
		}
}
///////////////
arr_state_functions[STATES.down] = function(){
	xadd = approach(xadd, ground_fric, 0);
    yadd = 0;
	if(state_changed){add_state(); }
	if(anim_done){
		if(handle_array()){return;}
		image_index = 2
		image_speed=0
		}
		if(image_index >= 2){
		if(input.is_just_pressed(INPUT.right)){restart_state(STATES.right);image_index = 0 ; anim_done=false;}
		if(input.is_just_pressed(INPUT.left)){ restart_state(STATES.left); image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.up)){ restart_state(STATES.up);image_index = 0; anim_done=false;}
		if(input.is_just_pressed(INPUT.down)) {restart_state(STATES.down);image_index = 0; anim_done=false;}
		}
	
}

spell_array = [];
function add_state(){
	
    array_push(spell_array, state);

    if (array_length(spell_array) >= 3) {
        array_delete(spell_array, 0, 1);
    }
	show_debug_message("spell array= " + string(spell_array));
}

function handle_array() {
    if (array_length(spell_array) < 2) return false;

    var a = spell_array[0];
    var b = spell_array[1];
    if (a == STATES.left && b == STATES.left) {
        spell_array = [];
        change_state(STATES.special1);
        return true;
    }
    if (a == STATES.right && b == STATES.right) {
        spell_array = [];
        change_state(STATES.special2);
        return true;
    }
    if (a == STATES.up && b == STATES.up) {
        spell_array = [];
        change_state(STATES.special3);
        return true;
    }
    if (a == STATES.down && b == STATES.down) {
        spell_array = [];
        change_state(STATES.heavy);
        return true;
    }
    return false;
}
function restart_state(_state) {
    change_state(_state);

    // force same-state transition to count as changed
    state_prev = -1;
    state_changed = true;
}