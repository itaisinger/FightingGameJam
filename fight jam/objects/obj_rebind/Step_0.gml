var _input = [];
_input[0] = new FrameInput(true);
_input[1] = new FrameInput(false);
var _binds = global.user_keybinds;

select_yoff = approach(select_yoff, 1, 0)//wave(-select_yoffmax,select_yoffmax,3));

if(is_choosing and keyboard_lastkey != vk_nokey)
{
	_binds[index][is_p1] = keyboard_lastkey;
	is_choosing = false;
}
else
{
	//down
	if(_input[0].is_pressed(INPUT.down_press) or _input[1].is_pressed(INPUT.down_press))
	{	
		select_yoff = select_yoffmax;
		index++;
		if(index >= INPUT.max)
			index = 0;
		_bind = _binds[index];
	}
	//up
	if(_input[0].is_pressed(INPUT.up_press) or _input[1].is_pressed(INPUT.up_press))
	{	
		select_yoff = select_yoffmax;
		index--;
		if(index < 0)
			index = INPUT.max-1;
		_bind = _binds[index];
	}
	//switch player
	if(_input[0].is_pressed(INPUT.right_press) or _input[1].is_pressed(INPUT.right_press) or _input[0].is_pressed(INPUT.left_press) or _input[1].is_pressed(INPUT.left_press))
	{
		is_p1 = !is_p1;
		select_yoff = select_yoffmax;
	}
	
	//choose
	if(_input[0].is_pressed(INPUT.light) or _input[1].is_pressed(INPUT.light))
		is_choosing = true;
	
	//reset
	if(_input[0].is_pressed(INPUT.heavy) or _input[1].is_pressed(INPUT.heavy))
		_binds[index][is_p1] = global.def_keybinds[index][is_p1];
}
keyboard_lastkey = vk_nokey;