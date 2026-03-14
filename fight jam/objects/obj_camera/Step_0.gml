follow_x = (arr_players[0].x + arr_players[1].x)/2
x = lerp(x,follow_x,0.05);
x = approach(x,1,follow_x);

view_set_xport(0,x-camera_get_view_width(view_camera[0]/2));