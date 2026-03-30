enum hitboxdata{
	sprite,
	damage,
	stun_duration,
	knockback_x,
	knockback_y,
	give_echo_charge,
	func,
}
function HitboxData(sprite,_damage,_stun_duration,_hitpause,_knockback_x,_knockback_y,_give_echo_charge,_is_launcher,_is_parry,_func=function(){},_hit_spd_up=3) constructor {
	sprite_index = sprite;
	damage = _damage;
	stun_duration = _stun_duration;
	knockback_x = _knockback_x;
	knockback_y = _knockback_y;
	give_echo_charge = _give_echo_charge;
	hitpause = _hitpause;
	is_launcher = _is_launcher;
	is_parry = _is_parry;
	func = _func
	hit_speedup = _hit_spd_up;
}

function create_hitbox(_hitbox_data){
	
	if(inst_hitbox != noone)
		instance_destroy(inst_hitbox)
	
	inst_hitbox = instance_create_depth(x,y,depth,obj_hitbox,_hitbox_data);
	inst_hitbox.dir = dir;
	inst_hitbox.image_xscale = dir;
	inst_hitbox.image_index = image_index;
	inst_hitbox.parent = self;
	
}