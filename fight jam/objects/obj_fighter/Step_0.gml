//INPUT

//array_insert(echo_record_arr,current_input);
//array_delete(echo_record_arr,0,1);

input = get_input();

//STATE
state_prev = state;
state_count++;
arr_state_functions[state]();

anim_done = false;


//MOVEMENT
collision_movement(xadd,yadd);

