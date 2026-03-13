keybinds[INPUT.left]	= [ord("A"),vk_left]
keybinds[INPUT.right]	= [ord("D"),vk_right]
keybinds[INPUT.up]		= [ord("W"),vk_up]
keybinds[INPUT.down]	= [ord("S"),vk_down]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6]

arr[INPUT.left]	 = keyboard_check(keybinds[INPUT.left][P1]);
arr[INPUT.right] = keyboard_check(keybinds[INPUT.right][P1]);
arr[INPUT.up]	 = max(5*keyboard_check_pressed(keybinds[INPUT.up][P1]),keyboard_check_pressed(keybinds[INPUT.up][P1])-1);
arr[INPUT.down]	 = keyboard_check_pressed(keybinds[INPUT.down][P1]);
arr[INPUT.light] = keyboard_check_pressed(keybinds[INPUT.light][P1]);
arr[INPUT.heavy] = keyboard_check_pressed(keybinds[INPUT.heavy][P1]);
arr[INPUT.dodge] = keyboard_check_pressed(keybinds[INPUT.dodge][P1]);