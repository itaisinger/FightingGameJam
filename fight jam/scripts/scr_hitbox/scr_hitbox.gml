enum hitboxdata{
	sprite,
	damage,
	stun_duration,
	knockback_x,
	knockback_y,
	give_echo_charge,
}
function HitboxData(sprite,_damage,_stun_duration,_hitpause,_knockback_x,_knockback_y,_give_echo_charge,_is_launcher) constructor {
	sprite_index = sprite;
	damage = _damage;
	stun_duration = _stun_duration;
	knockback_x = _knockback_x;
	knockback_y = _knockback_y;
	give_echo_charge = _give_echo_charge;
	hitpause = _hitpause
	is_launcher = _is_launcher
}