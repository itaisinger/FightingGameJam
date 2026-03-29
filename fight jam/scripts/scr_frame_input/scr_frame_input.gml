enum INPUT{
	left_press,
	right_press,
	left,
	right,
	up,
	down,
	light,
	light_down,
	heavy,
	heavy_down,
	dodge,
	special,
	echo,
}


function FrameInput(P1) constructor{
	
	try{
			arr[INPUT.left]	 = obj_input.arr[P1][INPUT.left];
			arr[INPUT.left_press]	 = obj_input.arr[P1][INPUT.left_press];
			arr[INPUT.right] = obj_input.arr[P1][INPUT.right];
			arr[INPUT.right_press] = obj_input.arr[P1][INPUT.right_press];
			arr[INPUT.down]	 = obj_input.arr[P1][INPUT.down];
			arr[INPUT.up]	 = obj_input.arr[P1][INPUT.up];
			arr[INPUT.light] = obj_input.arr[P1][INPUT.light];
			arr[INPUT.light_down] = obj_input.arr[P1][INPUT.light_down];
			arr[INPUT.heavy_down] = obj_input.arr[P1][INPUT.heavy_down];
			arr[INPUT.heavy] = obj_input.arr[P1][INPUT.heavy];
			arr[INPUT.dodge] = obj_input.arr[P1][INPUT.dodge];
			arr[INPUT.special] = obj_input.arr[P1][INPUT.special];
			arr[INPUT.echo] = obj_input.arr[P1][INPUT.echo];
	}
	catch(e) {
		arr[INPUT.left]		= false;
		arr[INPUT.right]	= false;
		arr[INPUT.left_press]	= false;
		arr[INPUT.right_press]	= false;
		arr[INPUT.down]		= false;
		arr[INPUT.up]		= false;
		arr[INPUT.light]	= false;
		arr[INPUT.light_down]	= false;
		arr[INPUT.heavy_down]	= false;
		arr[INPUT.heavy]	= false;
		arr[INPUT.dodge]	= false;
		arr[INPUT.special]	= false;
		arr[INPUT.echo]	= false;
	}
	
	function is_pressed(input){ return arr[input]; }

}


