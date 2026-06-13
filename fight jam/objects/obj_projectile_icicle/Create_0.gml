// obj_icicle Create Event
event_inherited();

angle = 30;
spd = 9;
parried = false;

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