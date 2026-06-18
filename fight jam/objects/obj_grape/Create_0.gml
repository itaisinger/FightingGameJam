event_inherited();

//STATS
max_hp *= 1.2;
hp = max_hp;
walkspd -= 1.7;
grav *= 0.7;
jumpforce_y *= 1;
jumpforce_x *= 0.7;
fly_mult = 1;

frog_remain = 0;

name = "GRAPE"
win_sfx = sfx_grape_wins;

//particles
part_active = part_system_create(part_magic_active);
part_passive = part_system_create(part_magic_passive);
var _info_active = part_system_get_info(part_active);
var _info_passive = part_system_get_info(part_passive);
emitter_active = _info_active.emitters[0].ind;
emitter_passive = _info_passive.emitters[0].ind;
part_type_active = _info_active.emitters[0].parttype.ind;
part_type_passive = _info_passive.emitters[0].parttype.ind;
part_number_active = _info_active.emitters[0].number;
part_number_passive = _info_passive.emitters[0].number;

part_system_depth(part_passive,depth-1);
part_system_depth(part_active,depth+1);

part_system_automatic_update(part_active,false)
part_system_automatic_update(part_passive,false)

part_set_enabled(1,0);

states_sprites = array_create(STATES.max,-1);
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
states_sprites[STATES.teleport]		= spr_grape_tp_2;
states_sprites[STATES.special]		= spr_grape_special;
states_sprites[STATES.land]			= spr_grape_land;
states_sprites[STATES.air_light]	= spr_grape_air_light;
states_sprites[STATES.air_heavy]	= spr_grape_air_heavy_start;
states_sprites[STATES.air_heavy2]	= spr_grape_air_heavy2;
states_sprites[STATES.air_heavy3]	= spr_grape_air_heavy3;
states_sprites[STATES.air_special]	= spr_grape_special;
states_sprites[STATES.special_ex]	= spr_grape_explosion;
states_sprites[STATES.frog]			= spr_frog;
states_sprites[STATES.frog_jump]	= spr_frog_air;
states_sprites[STATES.frog_attack]	= spr_frog_attack;

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
states_hurtboxes[STATES.air_special]= hurtbox_grape_special;
states_hurtboxes[STATES.land]		= hurtbox_grape_land;
states_hurtboxes[STATES.air_light]	= hurtbox_grape_air_light;
states_hurtboxes[STATES.air_heavy]	= hurtbox_grape_air_heavy_start;
states_hurtboxes[STATES.air_heavy2]	= hurtbox_grape_air_heavy2;
states_hurtboxes[STATES.air_heavy3]	= hurtbox_grape_air_heavy3;
states_hurtboxes[STATES.left]		= hurtbox_grape_idle;
states_hurtboxes[STATES.right]		= hurtbox_grape_idle;
states_hurtboxes[STATES.up]			= hurtbox_grape_idle;
states_hurtboxes[STATES.down]		= hurtbox_grape_idle;
states_hurtboxes[STATES.special_ex]	= hurtbox_grape_explosion;
states_hurtboxes[STATES.frog]		= hurtbox_frog;
states_hurtboxes[STATES.frog_jump]	= hurtbox_frog_air;
states_hurtboxes[STATES.frog_attack]= hurtbox_frog_attack;
mask_index = spr_grape_idle

/// ATTACKS DATA (overrided in different characters)
hitbox_data = array_create(STATES.max,-1)
hitbox_data[STATES.light]		= new HitboxData(hitbox_grape_light,4,45,5,3,4,0,0,false);
hitbox_data[STATES.heavy]		= new HitboxData(hitbox_grape_heavy,8,100,15,4.5,10,0,1,false);
hitbox_data[STATES.air_light]	= new HitboxData(hitbox_grape_air_light,5,60,5,3,7,0,0,false);
hitbox_data[STATES.air_heavy2]	= new HitboxData(hitbox_grape_air_heavy3,4,30,10,2,5,0,0,false);
hitbox_data[STATES.air_heavy3]	= new HitboxData(hitbox_grape_air_heavy3,4,70,10,4,6,0,0,false);
hitbox_data[STATES.special_ex]	= new HitboxData(hitbox_grape_explosion,12,70,13,2,8,0,0,false);
hitbox_data[STATES.parry]		= new HitboxData(hitbox_grape_parry,1,100,180,3,3,1,false,true);
hitbox_data[STATES.frog_attack]	= new HitboxData(hitbox_frog_attack,1,0,1,0,0,0,false,false);
inst_hitbox = noone;	//saves the currently active hitbox.

//magic
//special moves
//1
states_sprites[STATES.special1]		= spr_grape_spell_ice;
states_hurtboxes[STATES.special1]	= hurtbox_grape_special;
//2
states_sprites[STATES.special2]		= spr_grape_spell_fire;
states_hurtboxes[STATES.special2]	= hurtbox_grape_special;
//3
states_sprites[STATES.special3]		= spr_grape_spell_air_1;
states_hurtboxes[STATES.special3]	= hurtbox_grape_special;
//4
states_sprites[STATES.special4]		= spr_grape_spell_grass;
states_hurtboxes[STATES.special4]	= hurtbox_grape_special;

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
		xadd += dir * 3.0;
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
		xadd += dir * 3.2;
		
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
arr_state_functions[STATES.dead] = function(){
	
	if(state_changed){
		
		//wand
		var _inst = instance_create_depth(x + dir*5, y - sprite_height/2,depth,obj_wand);
		_inst.xadd = abs(xadd+2)*-1;
		_inst.yadd = min(yadd*1.3,-3);
		_inst.is_echo = is_echo;
		_inst.apply_phy(-1,1.2)
		_inst.floor_y = floor_y
		
		//hat
		create_hat();
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
		__yadd_prev = yadd;
		yadd = -4;
		xadd = -2*dir;
	}
	
	//transition to air_special
	if(state_count <= special_trans_grace_length && input.is_pressed(INPUT.special))
	{
		yadd = __yadd_prev;
		change_state(STATES.air_special);
	}

	yadd += grav;
	__yadd_prev += grav;
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
		jump_traj_x = xadd * 0.8;
		__active_remain = 30;
	}
	
	var _m = 1;
	if(input.is_pressed(INPUT.up) and !input.is_pressed(INPUT.down)) _m = 1.3;
	if(!input.is_pressed(INPUT.up) and input.is_pressed(INPUT.down)) _m = 0.7;
	yadd += _yadd * _m;
	
	//end
	if(__active_remain-- <= 0)
	{
		change_state(STATES.air)
	}
	
	//land
	if(is_grounded())
	{
		xadd *= 1.4;
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
arr_state_functions[STATES.special] = function(){

	if(state_changed)
	{
		arr_sigils = [];
		jump_traj_x = 0;
		part_set_enabled(1,1);
	}

    xadd = lerp(xadd, 0, 0.06);
    yadd = lerp(yadd, 0, 0.06) + grav * 0.1;
	
	//cancel
	if((input.is_pressed(INPUT.dodge) or input.is_pressed(INPUT.special)) and state_count > 6){
		change_state(STATES.air);
	}
	
	if(sprite_index != states_sprites[state])
		image_index = min(image_index,image_number-0.7);
	
	//input sign
    if(input.is_pressed(INPUT.up_press))
        cast_sigil(SIGILS.up);

    if(input.is_pressed(INPUT.right_press))
        cast_sigil(SIGILS.right);

    if(input.is_pressed(INPUT.down_press))
        cast_sigil(SIGILS.down);

    if(input.is_pressed(INPUT.left_press))
        cast_sigil(SIGILS.left);
}
arr_state_functions[STATES.air_special] = arr_state_functions[STATES.special];
///// ice
arr_state_functions[STATES.special1] = function(){
		
		yadd += grav * 0.8;
		xadd = approach(xadd,air_fric * 0.8, 0);
		//if(state_changed){play_sfx(sfx_ice_spawn)}
		if(state_changed){play_sfx(ice_spawn_done)}
		if (reached_frame(1)){
			create_projectile(obj_projectile_icicle,0, -250);
		}
		if(anim_done)
		{
			change_state(is_grounded() ? STATES.idle : STATES.air);
		}
}
///// fireball
arr_state_functions[STATES.special2] = function(){
	
	yadd += grav * 0.8;
	xadd = approach(xadd,air_fric * 0.8, 0);
	
	if(state_changed){play_sfx(sfx_fire_spawn_done)}
	
	//create fireball
	if (reached_frame(1)){
		create_projectile(obj_projectile_fireball,30,-30);
	}
	
	if(anim_done)
	{
		change_state(is_grounded() ? STATES.idle : STATES.air);
	}
}
///// dash
arr_state_functions[STATES.special3] = function(){
	
	if(state_changed){
		var n = irandom_range(1, 2);
		if(n==2) play_sfx(wind_2crunched)
		if(n==1) play_sfx(wind_3_crunched)
		__grav_mult = 0;
		
		var _yprev = yadd;
		if(fly_mult > 0.01) 
			yadd = lerp(yadd,-4,fly_mult);
		fly_mult = approach(fly_mult,0.2,0);
		if(is_grounded()){
			yadd -= 6;
		}
		//log(string(_yprev) + " -> " + string(yadd));

		xadd = 15*dir;
		jump_traj_x = xadd;
		create_vfx(x, y, air_burst_1, dir, 1);
	}
	
	//trans out
	if(input.is_pressed(INPUT.light))
		change_state(STATES.air_light);
	if(input.is_pressed(INPUT.heavy))
		change_state(STATES.air_heavy);
		
	yadd += grav * __grav_mult;
	xadd = approach(xadd,air_fric,0);
	__grav_mult = approach(__grav_mult,0.075,1);
	
	if(is_grounded())
	{
		xadd *= 1.2;
		change_state(STATES.idle);
	}
	
	if(anim_done){
		change_state(STATES.air);
	}
	
}
////// tree
arr_state_functions[STATES.special4] = function(){
	if(state_changed){
		create_projectile(obj_projectile_grape_tree, 0, floor_y - y);
	}
	if(anim_done)
		change_state(STATES.idle);
	
}
///// explosion
arr_state_functions[STATES.special_ex] = function(){
	
	if(is_grounded())
	{
		image_speed = 1;
		
		if(reached_frame(2))
		{
			xadd += dir * 2;
			create_vfx(x,y-sprite_height/3,vfx_magic_explosion,3,3,random(360),1);
		}
	
		xadd = approach(xadd,slide_fric,0);
		yadd = 0;
	
		if(anim_done)
			change_state(STATES.idle);
	}
	else
	{
		if(state_changed)
		{
			yadd -= 1;
			xadd += 3*dir;
		}
		
		xadd = approach(xadd,air_fric,0);
		yadd += grav;

		image_index = min(image_index, 1.7);
	}	
}
arr_state_functions[STATES.frog] = function(){
	
	shadow_w = 0.5;
	
	frog_remain--;
	
	if(frog_remain <= 0)
	{
		change_state(STATES.idle);
	}
	
	yadd = 0;
	xadd = approach(xadd,ground_fric,0);
	
	var _dir = sign(input.is_pressed(INPUT.right) - input.is_pressed(INPUT.left));
	if(input.is_pressed(INPUT.up) or _dir != 0)
	{
		change_state(STATES.frog_jump);
		yadd -= jumpforce_y * 0.4;
		xadd = jumpforce_x * _dir;
		dir_locked = true;
	}
	
	if(input.is_pressed(INPUT.light) or input.is_pressed(INPUT.heavy))
	{
		change_state(STATES.frog_attack);
	}
}
arr_state_functions[STATES.frog_attack] = function(){

	shadow_w = 0.5;

	frog_remain--;
	
	if(frog_remain <= 0)
	{
		change_state(STATES.idle);
	}
	
	yadd = 0;
	xadd = approach(xadd,ground_fric,0);
	
	if(anim_done)
	{
		change_state(STATES.frog);
	}
}
arr_state_functions[STATES.frog_jump] = function(){
	
	dir_locked = true;
	shadow_w = 0.5;

	frog_remain--;
	
	if(frog_remain <= 0)
	{
		change_state(STATES.air);
	}
	
	yadd += grav*0.5;
	xadd = approach(xadd,air_fric * 0.6,0);
	
	image_index = yadd > 0;
	
	if(is_grounded())
	{
		change_state(STATES.frog);
	}
}

enum SIGILS{
	up,
	down,
	left,
	right
}
arr_sigils = [];

function Spell(_state,_sigils_arr,_dir=1) constructor
{
	state = _state;
	sigils = _sigils_arr;
	dir = _dir;
}

arr_spells[0] = new Spell(STATES.special1,		[SIGILS.left, SIGILS.left])
arr_spells[1] = new Spell(STATES.special2,		[SIGILS.down, SIGILS.right])
arr_spells[2] = new Spell(STATES.special3,		[SIGILS.up, SIGILS.right])
arr_spells[3] = new Spell(STATES.special4,		[SIGILS.down, SIGILS.down])
arr_spells[4] = new Spell(STATES.special_ex,	[SIGILS.right, SIGILS.left, SIGILS.up, SIGILS.down])
arr_spells[5] = new Spell(turn_to_frog,			[SIGILS.right, SIGILS.left, SIGILS.down, SIGILS.up])

//duplicate spells for turnaround
var _l = array_length(arr_spells);
for(var i=0; i < _l; i++)
{
	var _spell = variable_clone(arr_spells[i]);
	_spell.dir = -1;
	
	//flip dirs
	for(var s=0; s < array_length(_spell.sigils); s++)
	{
		switch(_spell.sigils[s])
		{
			case SIGILS.right: _spell.sigils[s] = SIGILS.left; break;
			case SIGILS.left: _spell.sigils[s] = SIGILS.right; break;
		}
	}
	
	arr_spells[array_length(arr_spells)] = _spell;
}

function cast_sigil(_dir)
{
	//anim
	switch(_dir){
		case SIGILS.right:	sprite_index = spr_grape_sign_right;	break;	
		case SIGILS.left:	sprite_index = spr_grape_sign_left;		break;	
		case SIGILS.up:		sprite_index = spr_grape_sign_up;		break;	
		case SIGILS.down:	sprite_index = spr_grape_sign_down;		break;	
	}
	
	//insert new sign
	arr_sigils[array_length(arr_sigils)] = _dir;
	
	/// cast spell
	
	//gather options
	var _spells_remain = [];
	for(var i=0; i < array_length(arr_spells); i++)
		_spells_remain[i] = arr_spells[i];
	
	//loop spells
	for(var i=0; i < array_length(_spells_remain); i++)
	{
		var _stop = false;
		
		//loop sigils
		for(var s=0; s < array_length(arr_sigils) and !_stop; s++)
		{
			var _spell = _spells_remain[i]
			
			//filter out spell
			if(s >= array_length(_spell.sigils) or arr_sigils[array_length(arr_sigils)-1-s] != _spell.sigils[array_length(_spell.sigils)- s-1])
			{
				array_delete(_spells_remain,i,1);
				i--;
				_stop = true;
			}
			//cast
			else if(array_length(_spell.sigils) == s+1)
			{
				dir = _spell.dir;
				if(_spell.state == turn_to_frog) method(self,_spell.state)();
				else change_state(_spell.state);
				part_set_enabled(1,1);
				return;
			}
		}
	}
}
function restart_state(_state) {
    change_state(_state);

    // force same-state transition to count as changed
    state_prev = -1;
    state_changed = true;
}
function turn_to_frog(){
	frog_remain = room_speed * 8;
	change_state(is_grounded() ? STATES.frog : STATES.frog_jump);
	var _inst = create_hat();
	_inst.spd_mult = 0.4;
	_inst.depth = depth-2;
	var _vfx = create_vfx(x,y,vfx_grape_disappeaer,2,2);
	_vfx.depth = depth-1;
}
function create_hat()
{
	var _inst = instance_create_depth(x,y - sprite_height/2,depth,obj_hat);
	_inst.xadd = xadd;
	_inst.yadd = min(yadd/2,-3);
	_inst.floor_y = floor_y
	_inst.is_echo = is_echo
	return _inst;
}
function part_set_enabled(is_active=1,is_enabled=1)
{
	var _system = is_active ? part_active : part_passive;
	var _emitter = is_active ? emitter_active : emitter_passive;
	var _part = is_active ? part_type_active : part_type_passive;
	var _number = is_active ? part_number_active : part_number_passive;
	part_emitter_enable(_system,_emitter,is_enabled)
	
	if(is_enabled)
	{
		part_emitter_stream(_system,_emitter,_part,_number)
	}
	else
	{
		part_emitter_clear(_system,_emitter);
	}
	

}