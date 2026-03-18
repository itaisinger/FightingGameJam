event_inherited();
if(step_delay_remain > 0)
{
	exit;
}

grounded = place_meeting(x,y+1,obj_floor);

xadd = approach(xadd, grounded ? ground_fric : air_fric, 0);
yadd = grounded ? 0 : yadd + grav;

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
if(place_meeting(x+xadd,y,obj_wall))
	xadd *= -0.5;
if(place_meeting(x,y+yadd,obj_floor)){
	
	landed = true;
	
	if(abs(yadd) > 2){
		yadd *= -0.4;
	}
}
while (place_meeting(x+xadd,y,obj_wall)) xadd = approach(xadd,1,0);
	
//ver
while (place_meeting(x,y+yadd,obj_floor)) yadd = approach(yadd,1,0);

image_index = !(grounded or landed);
image_xscale = xadd > 0 ? 1 : -1;

x += xadd;
y += yadd;
