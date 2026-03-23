keybinds[INPUT.left]	= [ord("A"),vk_left]
keybinds[INPUT.right]	= [ord("D"),vk_right]
keybinds[INPUT.up]		= [ord("W"),vk_up]
keybinds[INPUT.down]	= [ord("S"),vk_down]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6]
keybinds[INPUT.echo]	= [vk_lshift,vk_numpad0]


if(gamepad_is_connected(padindex)){
	gleft   = gamepad_button_check(padindex, gp_padl) || gamepad_axis_value(padindex, gp_axislh) < -0.5;
	gright  = gamepad_button_check(padindex, gp_padr) || gamepad_axis_value(padindex, gp_axislh) >  0.5;
	gup     = gamepad_button_check_pressed(padindex, gp_padu) || gamepad_axis_value(padindex, gp_axislv) < -0.5;
	gdown   = gamepad_button_check(padindex, gp_padd) || gamepad_axis_value(padindex, gp_axislv) >  0.5;
	
	
	gup= gup || gamepad_button_check_pressed(padindex, gp_face1);
	gdodge  = gamepad_button_check_pressed(padindex, gp_face2);
	glight  = gamepad_button_check_pressed(padindex, gp_face3);
	gheavy  = gamepad_button_check_pressed(padindex, gp_face4);
	gecho   = gamepad_button_check_pressed(padindex, gp_shoulderlb);
	gspecial =gamepad_button_check_pressed(padindex, gp_shoulderr); 
	gleft_press  = gamepad_button_check_pressed(padindex, gp_padl) ||(gamepad_axis_value(padindex, gp_axislh) < -0.5 && axis > -0.5 ) ;
	gright_press = gamepad_button_check_pressed(padindex, gp_padr)||(gamepad_axis_value(padindex, gp_axislh) > 0.5 && axis < 0.5 );	
	axis=gamepad_axis_value(padindex, gp_axislh);
}


if ((keyboard_check_pressed(keybinds[INPUT.heavy][true]) || gheavy) &&  (keyboard_check_pressed(keybinds[INPUT.light][true]) || glight))
{ log("special"); }
	arr[INPUT.left]= max(5  * (keyboard_check(keybinds[INPUT.left][true])  || gleft),  arr[INPUT.left] - 1);
	arr[INPUT.left_press]  = keyboard_check_pressed(keybinds[INPUT.left][true])|| gleft_press ;
	arr[INPUT.right]= max(5  * (keyboard_check(keybinds[INPUT.right][true]) || gright), arr[INPUT.right] - 1);
	arr[INPUT.right_press] = keyboard_check_pressed(keybinds[INPUT.right][true]) || gright_press;
	arr[INPUT.up]= max(5  * (keyboard_check_pressed(keybinds[INPUT.up][true]) || gup), arr[INPUT.up] - 1);
	arr[INPUT.down]= max(10 * (keyboard_check(keybinds[INPUT.down][true]) || gdown), arr[INPUT.down] - 1);
	arr[INPUT.light]= max(5  * (keyboard_check_pressed(keybinds[INPUT.light][true]) || glight), arr[INPUT.light] - 1);
	arr[INPUT.heavy]= max(5  * (keyboard_check_pressed(keybinds[INPUT.heavy][true]) || gheavy), arr[INPUT.heavy] - 1);
	arr[INPUT.dodge]= max(10 * (keyboard_check_pressed(keybinds[INPUT.dodge][true]) || gdodge), arr[INPUT.dodge] - 1);
	arr[INPUT.echo]        = keyboard_check_pressed(keybinds[INPUT.echo][true]) || gecho;
	arr[INPUT.special]     = arr[INPUT.heavy] && arr[INPUT.light];
if(arr[INPUT.left] > arr[INPUT.right])  
	arr[INPUT.right]=0;
else{
	if(arr[INPUT.left] < arr[INPUT.right])
		arr[INPUT.left]=0;
	else {
		arr[INPUT.left]=0; arr[INPUT.right]=0;
	}
}

