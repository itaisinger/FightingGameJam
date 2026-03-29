keybinds[INPUT.left]	= [ord("A"),vk_left]
keybinds[INPUT.right]	= [ord("D"),vk_right]
keybinds[INPUT.up]		= [ord("W"),vk_up]
keybinds[INPUT.down]	= [ord("S"),vk_down]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6]
keybinds[INPUT.echo]	= [vk_lshift,vk_numpad0]

for(var i=0;i<2;i++){
	
	var	gleft   = gamepad_button_check(padindex[i], gp_padl) || gamepad_axis_value(padindex[i], gp_axislh) < -0.5;
	var	gright  = gamepad_button_check(padindex[i], gp_padr) || gamepad_axis_value(padindex[i], gp_axislh) >  0.5;
	var	gup     = gamepad_button_check_pressed(padindex[i], gp_padu) || gamepad_axis_value(padindex[i], gp_axislv) < -0.5;
	var	gdown   = gamepad_button_check(padindex[i], gp_padd) || gamepad_axis_value(padindex[i], gp_axislv) >  0.5;

	var	gup= gup || gamepad_button_check_pressed(padindex[i], gp_face1);
	var	gdodge  = gamepad_button_check_pressed(padindex[i], gp_face2);
	var	glight  = gamepad_button_check_pressed(padindex[i], gp_face3);
	var	glight_down  = gamepad_button_check(padindex[i], gp_face3);
	var	gheavy		 = gamepad_button_check_pressed(padindex[i], gp_face4);
	var	gheavy_down  = gamepad_button_check(padindex[i], gp_face4);
	var	gecho   = gamepad_button_check_pressed(padindex[i], gp_shoulderlb);
	var	gspecial =gamepad_button_check_pressed(padindex[i], gp_shoulderr); 
	var	gleft_press  = gamepad_button_check_pressed(padindex[i], gp_padl) ||(gamepad_axis_value(padindex[i], gp_axislh) < -0.5 && axis[i] > -0.5 ) ;
	var	gright_press = gamepad_button_check_pressed(padindex[i], gp_padr)||(gamepad_axis_value(padindex[i], gp_axislh) > 0.5 && axis[i] < 0.5 );	
	axis[i]=gamepad_axis_value(padindex[i], gp_axislh);


	arr[i][INPUT.left]			= max(5  * (keyboard_check(keybinds[INPUT.left][i])  || gleft),  arr[i][INPUT.left] - 1);
	arr[i][INPUT.left_press]	= keyboard_check_pressed(keybinds[INPUT.left][i])|| gleft_press ;
	arr[i][INPUT.right]			= max(5  * (keyboard_check(keybinds[INPUT.right][i]) || gright), arr[i][INPUT.right] - 1);
	arr[i][INPUT.right_press]	= keyboard_check_pressed(keybinds[INPUT.right][i]) || gright_press;
	arr[i][INPUT.up]			= max(5  * (keyboard_check_pressed(keybinds[INPUT.up][i]) || gup), arr[i][INPUT.up] - 1);
	arr[i][INPUT.down]			= max(10 * (keyboard_check(keybinds[INPUT.down][i]) || gdown), arr[i][INPUT.down] - 1);
	arr[i][INPUT.light]			= max(5  * (keyboard_check_pressed(keybinds[INPUT.light][i]) || glight), arr[i][INPUT.light] - 1);
	arr[i][INPUT.light_down]	= keyboard_check(keybinds[INPUT.light][i]) || glight_down;
	arr[i][INPUT.heavy_down]	= keyboard_check(keybinds[INPUT.heavy][i]) || gheavy_down;
	arr[i][INPUT.heavy]			= max(5  * (keyboard_check_pressed(keybinds[INPUT.heavy][i]) || gheavy), arr[i][INPUT.heavy] - 1);
	arr[i][INPUT.dodge]			= max(10 * (keyboard_check_pressed(keybinds[INPUT.dodge][i]) || gdodge), arr[i][INPUT.dodge] - 1);
	arr[i][INPUT.echo]			= keyboard_check_pressed(keybinds[INPUT.echo][i]) || gecho;
	arr[i][INPUT.special]		= (arr[i][INPUT.heavy] && arr[i][INPUT.light]) or gspecial;
	
	if(arr[i][INPUT.left] > arr[i][INPUT.right])  
		arr[i][INPUT.right]=0;
	else{
		if(arr[i][INPUT.left] < arr[i][INPUT.right])
			arr[i][INPUT.left]=0;
		else {
			arr[i][INPUT.left]=0; arr[i][INPUT.right]=0;
		}
	}

}

