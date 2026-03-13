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
	
	arr[INPUT.left]	 = obj_input.arr[INPUT.left];
	arr[INPUT.right] = keyboard_check(keybinds[INPUT.right][P1]);
	arr[INPUT.up]	 = max(5*keyboard_check_pressed(keybinds[INPUT.up][P1]),keyboard_check_pressed(keybinds[INPUT.up][P1])-1);
	arr[INPUT.down]	 = keyboard_check_pressed(keybinds[INPUT.down][P1]);
	arr[INPUT.light] = keyboard_check_pressed(keybinds[INPUT.light][P1]);
	arr[INPUT.heavy] = keyboard_check_pressed(keybinds[INPUT.heavy][P1]);
	arr[INPUT.dodge] = keyboard_check_pressed(keybinds[INPUT.dodge][P1]);
	
	function is_pressed(input){ return arr[input]; }
}



//if(input.is_pressed(INPUT.light))
//{

//}

//input = new frame_input();