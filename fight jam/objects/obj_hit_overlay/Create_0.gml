arr_lines = [];	//[<angle gap, length factor>]
lines_amount = 5;
_power = 5;
start_a = 0;

function set(_x=room_width/2,_y=room_height/2,__power=10){
	lines_number = 20//floor(map_value(_power, 0,20, )
	_power = map_value(__power, 0,20, 0,5);
	
	x = _x;
	y = _y;
	
	start_a = random(360);
	
	for(var i=0; i < lines_amount; i++)
		arr_lines[i] = [360/lines_amount, max(0, -5 + random_range(0,3) * _power)]
}
function draw_hit_line(angle,length)
{
	//var _vertex = vertex_begin()
	
	//vertex_position(_vertex,)
	
	var _dis_to_edge_y = angle > 0 and angle < 180 ? y : room_height-y;
	var _dis_to_edge_x = angle > 270 or angle < 90 ? x : room_width-x;
	var _dis_to_edge = sqrt(power(_dis_to_edge_x,2) + power(_dis_to_edge_y,2));
	
	var _startx = x + lengthdir_x(length*5,angle);
	var _starty = y + lengthdir_y(length*5,angle);
	
	draw_set_all(1,c_white,font_main,fa_center,fa_middle);
	draw_text(_startx,_starty,_dis_to_edge);
}