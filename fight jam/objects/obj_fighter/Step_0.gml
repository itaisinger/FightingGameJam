//INPUT
if(!is_echo){
	
	//get input
	input = new frame_input(true);
	
	//save to echo
	array_insert(echo_record_arr,-1,input);
	if (array_length(echo_record_arr) > echo_size) array_delete(echo_record_arr,0,1);

}
else {
	input = echo_record_arr[frames_lived]
	frames_lived++;
	
	if(frames_lived >= array_length(echo_record_arr))
		instance_destroy();
}


//hitpause
if(hitpause_remain > 0){
	image_speed = 0;
	hitpause_remain--;
	exit;
}
else image_speed = 1;

//STATE
state_changed = state != state_prev;
state_prev = state;
state_count++;
arr_state_functions[state]();

anim_done = false;

//MOVEMENT
collision();
x += xadd;
y += yadd;

