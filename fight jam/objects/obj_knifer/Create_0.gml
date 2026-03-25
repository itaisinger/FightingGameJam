// Inherit the parent event
event_inherited();

function create_butterflies(){
	var _m = 10;
	for(var xx=bbox_left; xx <= bbox_right; xx += _m)
	{
		for(var yy=bbox_top; yy <= bbox_bottom; yy += _m)
		{
			instance_create_depth(xx,yy,depth-1,obj_buttefly);
		}
	}
}

function teleport(delta)
{
	x += delta;
	create_butterflies();
}