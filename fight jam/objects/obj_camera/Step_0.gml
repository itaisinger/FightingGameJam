var cam = view_get_camera(view_current);

//shake
if(current_time % 3 == 0)
{
	shake_x = random_range(-shake_remain,shake_remain);
	shake_y = random_range(-shake_remain,shake_remain);
}
shake_remain = approach(shake_remain,0.8,0);

//gather borders
var _min = room_width, _max = 0;
with(obj_character){
	_min = min(_min,x);
	_max = max(_max,x);
}

xdest = (_min+_max)/2;
x = lerp(x,xdest,0.02) + shake_x;

//zoom
var _zoom_dest = (abs(_max-_min) + 2*side_margin)/room_width;
zoom = clamp( lerp(zoom,_zoom_dest,0.02), zoom_min, zoom_max);
var _cam_h = base_h * zoom;
var _cam_w = base_w * zoom;

//y
y = map_value(zoom, zoom_min,zoom_max, room_height*0.97,room_height) + shake_y;

//set camera
var _camx = clamp(x-_cam_w/2,	0, room_width -_cam_w);
var _camy = clamp(y-_cam_h,		0, room_height-_cam_h);
camera_set_view_size(cam,_cam_w,_cam_h);
camera_set_view_pos(cam,_camx,_camy);