event_inherited();

if(step_delay_remain > 0)
{
	exit;
}

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

//kombo break teleport
if(input.is_pressed(INPUT.up) and input.is_pressed(INPUT.dodge) and !is_dead() and tp_cooldown<=0)
{
	tp_cooldown = 10;
	
	if(echo_charges_remain >= echo_tp_cost and tp_x != -1)
		combo_break();
	else
	{
		play_sfx(sfx_error);
		obj_ui.shake_echo(is_p1);	
	}
}
else if(tp_cooldown > 0) tp_cooldown--;

//hitpause
if(hitpause_remain > 0){
	image_speed_prev = max(image_speed_prev,image_speed);
	image_speed = 0;
	hitpause_remain--;
	exit;
}
else image_speed = image_speed_prev;

//create echo
if(input.is_pressed(INPUT.echo) and echo_saved != -1 and stun_remain <= 0 and echo_charges_remain>=0){
	create_echo()
	input.arr[INPUT.echo] = false;
}

//STATE
state_changed = state != state_prev;
state_prev = state;
state_count++;
arr_state_functions[state]();

//turn around
if(state_count < turnaround_grace_length)
{
	update_dir();
}

anim_done = false;
image_index_prev = image_index;

//MOVEMENT
collision();
x += xadd;
y += yadd;

//move hitbox
with(inst_hitbox){
	x = other.x;	
	y = other.y;
	dir = other.dir;
	image_xscale = other.image_xscale*other.scalex;
	image_yscale = other.image_yscale*other.scaley;
	image_speed = other.image_speed
	image_index = other.image_index
}

mask_index = hurtbox;


