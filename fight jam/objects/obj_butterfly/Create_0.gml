
function _create(parent){
	if(!place_meeting(x,y,parent)){
		instance_destroy();
		exit;
	}
	
	var stray = random(100) > 90;
	
	direction = 90 - dir*random_range(20,85);
	speed = 0.3 * random_range(0.2,0.8) * (1+stray*2);
	alarm[0] = random_range(10,30) * (1+stray*2);
	image_index = random(image_number);
	
	image_xscale = -0.5  * sign(dir);
	image_yscale =  0.5  * 1
	
	depth = DEPTH.vfx;
	image_speed = random_range(0.5,2);
	
}