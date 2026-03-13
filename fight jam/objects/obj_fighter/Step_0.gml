//INPUT
if(!is_echo){
	
	//get input
	input = new FrameInput(is_p1);
	
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
	image_speed_prev = max(image_speed_prev,image_speed);
	image_speed = 0;
	hitpause_remain--;
	exit;
}
else image_speed = image_speed_prev;

//STATE
state_changed = state != state_prev;
state_prev = state;
state_count++;
arr_state_functions[state]();

//kombo break teleport
if(input.is_pressed(INPUT.up) and input.is_pressed(INPUT.dodge) and echo_charges_remain >= echo_tp_cost){
	
	if (tp_x != -1)
		change_state(STATES.teleport);	
	else
		play_sfx(sfx_error);
}

anim_done = false;
image_index_prev = image_index;

//MOVEMENT
collision();
x += xadd;
y += yadd;

//move hitbox
with(inst_hitbox){
	x += other.xadd;
	y += other.yadd;
}

mask_index = hurtbox;

