xdest = room_width/2;
x = xdest;
zoom = 1;
zoom_dest = zoom;
side_margin = 200;
center_margin = 100;	//how far off center till i move
zoom_max = 1;
zoom_min = 0.7;

base_w = 1920;
base_h = 1080;

shake_remain = 0;
shake_x = 0;
shake_y = 0;

function add_shake(amount){
	shake_remain += amount*0.85;
}