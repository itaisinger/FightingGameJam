enum INPUT{
	left,
	right,
	up,
	down,
	light,
	heavy,
	dodge,
}


function FrameInput(P1) constructor{
	
	if(P1){
		
	arr[INPUT.left]	 =  obj_input.arr[INPUT.left];
	arr[INPUT.right] = obj_input.arr[INPUT.right];
	arr[INPUT.down]	 =  obj_input.arr[INPUT.down];
	arr[INPUT.up]	 =    obj_input.arr[INPUT.up];
	arr[INPUT.light] = obj_input.arr[INPUT.light];
	arr[INPUT.heavy] = obj_input.arr[INPUT.heavy];
	arr[INPUT.dodge] = obj_input.arr[INPUT.dodge];
	}else{
	arr[INPUT.left]	 =  obj_input2.arr[INPUT.left];
	arr[INPUT.right] = obj_input2.arr[INPUT.right];
	arr[INPUT.down]	 =  obj_input2.arr[INPUT.down];
	arr[INPUT.up]	 = obj_input2.arr[INPUT.up];
	arr[INPUT.light] = obj_input2.arr[INPUT.light];
	arr[INPUT.heavy] = obj_input2.arr[INPUT.heavy];
	arr[INPUT.dodge] = obj_input2.arr[INPUT.dodge];
	}
	
	
	//arr[INPUT.right] = max(5* keyboard_check(keybinds[INPUT.right][P1])        ,arr[INPUT.right]	-1);
	//arr[INPUT.up]	 = max(5* keyboard_check_pressed(keybinds[INPUT.up][P1])   ,arr[keybinds[INPUT.up]]-1);
	//arr[INPUT.down]	 = max(5* keyboard_check_pressed(keybinds[INPUT.down][P1]) ,arr[keybinds[INPUT.down]]-1);
	//arr[INPUT.light] = max(5* keyboard_check_pressed(keybinds[INPUT.light][P1]),arr[keybinds[INPUT.light]]-1);
	//arr[INPUT.heavy] = max(5* keyboard_check_pressed(keybinds[INPUT.heavy][P1]),arr[keybinds[INPUT.heavy]]-1);
	//arr[INPUT.dodge] = max(5* keyboard_check_pressed(keybinds[INPUT.dodge][P1]),arr[keybinds[INPUT.dodge]]-1);
	
	function is_pressed(input){ return arr[input]; }
}



//if(input.is_pressed(INPUT.light))
//{

//}

//input = new frame_input();