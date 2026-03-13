enum INPUT{
	left,
	right,
	up,
	light,
	heavy,
	dodge,
}


function frame_input(P1) constructor{
	
	keybinds[INPUT.left] = [ord("A"),vk_left]
	keybinds[INPUT.right] = [ord("D"),vk_right]
	keybinds[INPUT.up] = [ord("W"),vk_up]
	keybinds[INPUT.light] = [ord("J"),ord("4")]
	keybinds[INPUT.heavy] = [ord("K"),ord("5")]
	keybinds[INPUT.dodge] = [ord("L"),ord("6")]
	
	arr[INPUT.left]=keyboard_check(keybinds[INPUT.left]);
	arr[INPUT.right]=keyboard_check(keybinds[INPUT.right]);
	arr[INPUT.up]=keyboard_check_pressed(keybinds[INPUT.up]);
	arr[INPUT.light]=keyboard_check_pressed(keybinds[INPUT.light]);
	arr[INPUT.heavy]=keyboard_check_pressed(keybinds[INPUT.heavy]);
	arr[INPUT.dodge]=keyboard_check_pressed(keybinds[INPUT.dodge]);
		
	function is_pressed(input){ return arr[input]; }
	
}



//if(input.is_pressed(INPUT.light))
//{

//}

//input = new frame_input();