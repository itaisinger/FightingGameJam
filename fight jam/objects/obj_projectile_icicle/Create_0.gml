// obj_icicle Create Event
event_inherited();

angle = 30;
spd = 12;
parried = false;
image_xscale *= 2;
image_yscale *= 2;

parry = function()
{
	image_angle = 0;
	is_p1 = !is_p1;
	dir *= -1;
	image_xscale *= -1;
	life = life_max
	yadd = 0;
	xadd = spd * sqrt(2);
	
	parried = true;
}
data = new HitboxData(hitbox_spr,5,30,3,3,4,0,1,0,function(){hit(2)},,,vfx_ice_explosion);
//data = new HitboxData(hitbox_spr,5,10,3,3,2,0,0,0,function(){hit(2)},,sfx_fire_spawn_done,vfx_hit);