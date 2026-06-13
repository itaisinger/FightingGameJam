var _input = [];
_input[0] = new FrameInput(true);
_input[1] = new FrameInput(false);
var _binds = global.keybinds;


select_yoff[0] = approach(select_yoff[0], 1, wave(-select_yoffmax,select_yoffmax,3));
select_yoff[1] = approach(select_yoff[1], 1, wave(-select_yoffmax,select_yoffmax,3));

for(var i=0; i < 2; i++)
{
	if(is_choosing[i])
	{
	
	}
	else
	{
		if(_input[i].is_pressed(INPUT.down_press))
		{	
			select_yoff[i] = select_yoffmax;
			index[i]++;
			if(index[i] >= INPUT.max)
				index[i] = 0;
			_bind = _binds[index[i]];
		}
		if(_input[i].is_pressed(INPUT.up_press))
		{	
			select_yoff[i] = select_yoffmax;
			index[i]--;
			if(index[i] < 0)
				index[i] = INPUT.max-1;
			_bind = _binds[index[i]];
		}
		
		if(_input[i].is_pressed(INPUT.up_press))
			is_choosing[i] = !is_choosing[i];
	}
}