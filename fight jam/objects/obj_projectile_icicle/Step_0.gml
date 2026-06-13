event_inherited();

image_angle = -angle*dir

xadd = lengthdir_x(spd,angle)
yadd = lengthdir_y(spd,-angle)

if(place_meeting(x,y,obj_floor))
{
	destroy();
}