/// @description Insert description here
// You can write your code in this editor
keybinds[INPUT.left]	= [ord("A"),vk_left]
keybinds[INPUT.right]	= [ord("D"),vk_right]
keybinds[INPUT.up]		= [ord("W"),vk_up]
keybinds[INPUT.down]	= [ord("S"),vk_down]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6]

arr[INPUT.left]	 = max(5* keyboard_check(keybinds[INPUT.left][false])         ,arr[INPUT.left]-1);
arr[INPUT.right] = max(5* keyboard_check(keybinds[INPUT.right][false])        ,arr[INPUT.right]-1);
arr[INPUT.up]	 = max(5* keyboard_check_pressed(keybinds[INPUT.up][false])   ,arr[INPUT.up]-1);
arr[INPUT.down]	 = max(5* keyboard_check_pressed(keybinds[INPUT.down][false]) ,arr[INPUT.down]-1);
arr[INPUT.light] = max(5* keyboard_check_pressed(keybinds[INPUT.light][false]),arr[INPUT.light]-1);
arr[INPUT.heavy] = max(5* keyboard_check_pressed(keybinds[INPUT.heavy][false]),arr[INPUT.heavy]-1);
arr[INPUT.dodge] = max(5* keyboard_check_pressed(keybinds[INPUT.dodge][false]),arr[INPUT.dodge]-1);