keybinds[INPUT.left]	= [ord("A"),vk_left]
keybinds[INPUT.right]	= [ord("D"),vk_right]
keybinds[INPUT.up]		= [ord("W"),vk_up]
keybinds[INPUT.down]	= [ord("S"),vk_down]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6]

arr[INPUT.left]	 = max(5* keyboard_check(keybinds[INPUT.left][true])         ,arr[INPUT.left]-1);
arr[INPUT.left_press]	 = keyboard_check_pressed(keybinds[INPUT.left][true]);
arr[INPUT.right] = max(5* keyboard_check(keybinds[INPUT.right][true])        ,arr[INPUT.right]-1);
arr[INPUT.right_press] = keyboard_check_pressed(keybinds[INPUT.right][true])
arr[INPUT.up]	 = max(5* keyboard_check_pressed(keybinds[INPUT.up][true])   ,arr[INPUT.up]-1);
arr[INPUT.down]	 = max(10* keyboard_check(keybinds[INPUT.down][true]) ,arr[INPUT.down]-1);
arr[INPUT.light] = max(5* keyboard_check_pressed(keybinds[INPUT.light][true]),arr[INPUT.light]-1);
arr[INPUT.heavy] = max(5* keyboard_check_pressed(keybinds[INPUT.heavy][true]),arr[INPUT.heavy]-1);
arr[INPUT.dodge] = max(10* keyboard_check_pressed(keybinds[INPUT.dodge][true]),arr[INPUT.dodge]-1);
arr[INPUT.special] = min(arr[INPUT.heavy],arr[INPUT.light]);

if(arr[INPUT.left] > arr[INPUT.right])  
	arr[INPUT.right]=0;
else{
	if(arr[INPUT.left] < arr[INPUT.right])
		arr[INPUT.left]=0;
	else {
		arr[INPUT.left]=0; arr[INPUT.right]=0;
	}
}