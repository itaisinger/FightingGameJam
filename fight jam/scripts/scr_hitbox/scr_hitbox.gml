enum hitboxdata{
	damage,
	stun_duration,
	knockback_x,
	knockback_y,
	give_echo_charge,
}
function hitbox_data(damage,stun_duration,knockback_x,knockback_y,give_echo_charge) constructor {
	arr[hitboxdata.damage]=damage
	arr[hitboxdata.stun_duration]=stun_duration
	arr[hitboxdata.knockback_x]=knockback_x
	arr[hitboxdata.knockback_y]=knockback_y
	arr[hitboxdata.give_echo_charge]=give_echo_charge
}