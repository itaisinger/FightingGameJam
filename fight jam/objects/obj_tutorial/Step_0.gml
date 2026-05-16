if(keyboard_check_pressed(vk_anykey)){
	index++;

	if(index >= array_length(paths)) stop();
	else play();
}