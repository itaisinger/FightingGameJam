
if(!is_echo)
	current_input = get_player_input();


array_insert(echo_record_arr,current_input);
array_delete(echo_record_arr,0,1);

current_input = get_input();

state_prev = state;
state_count++;
arr_state_functions[state]();
