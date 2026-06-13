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