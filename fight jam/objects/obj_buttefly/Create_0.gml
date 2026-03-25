if(!place_meeting(x,y,obj_knifer)){
	instance_destroy();
	exit;
}

direction = random(360);
speed = random_range(0.5,2);
alarm[0] = random_range(70,100);