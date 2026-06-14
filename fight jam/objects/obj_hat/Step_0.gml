event_inherited();

if(step_delay_remain > 0)
{
	exit;
}

grounded = place_meeting(x,y+1,obj_floor);
var _max_spd = 9 * spd_mult;

if(grounded){
	xadd = approach(xadd, ground_fric, 0);
	yadd = 0;
}
else
{
	var _spd = 0.2;
	if(yadd > 0)
		xadd += wave(-0.4,0.4,5,0);
		//xadd += _spd * (wave(-0.4,0.4,5,0) > 0 ? 1 : -1);
	else
		xadd = approach(xadd, air_fric, 0); 
	yadd = yadd + grav;
}
xadd = clamp(xadd,-_max_spd,_max_spd);

/// COL

//push out of floor
while (place_meeting(x,y,obj_floor))
	y--;
		
//push out of walls
while (place_meeting(x,y,obj_wall)){
	var _wall = instance_place(x,y,obj_wall)
	x -= sign(_wall.image_xscale);
}
	
//hor
if(place_meeting(x+xadd,y,obj_wall)) xadd *= -0.4;
while (place_meeting(x+xadd,y,obj_wall)) xadd = approach(xadd,1,0);
	
//ver
while (place_meeting(x,y+yadd,obj_floor)) yadd = approach(yadd,1,0);

image_index = !grounded;
if(xadd != 0) image_xscale = (xadd > 0 ? 1 : -1) * map_value(abs(xadd), 0,_max_spd, 0.9,1.2);
image_yscale = map_value(_max_spd-abs(xadd), 0,_max_spd, 0.5,0.8)

x += xadd;
y += yadd;
