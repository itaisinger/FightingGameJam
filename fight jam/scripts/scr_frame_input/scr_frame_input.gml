enum INPUT{
	left_press,
	right_press,
	left,
	right,
	up,
	down,
	light,
	heavy,
	dodge,
	special,
}


function FrameInput(P1) constructor{
	
	try{
		if(P1)
		{
			arr[INPUT.left]	 = obj_input.arr[INPUT.left];
			arr[INPUT.left_press]	 = obj_input.arr[INPUT.left_press];
			arr[INPUT.right] = obj_input.arr[INPUT.right];
			arr[INPUT.right_press] = obj_input.arr[INPUT.right_press];
			arr[INPUT.down]	 = obj_input.arr[INPUT.down];
			arr[INPUT.up]	 = obj_input.arr[INPUT.up];
			arr[INPUT.light] = obj_input.arr[INPUT.light];
			arr[INPUT.heavy] = obj_input.arr[INPUT.heavy];
			arr[INPUT.dodge] = obj_input.arr[INPUT.dodge];
			arr[INPUT.special] = obj_input.arr[INPUT.special];
		}
		else
		{
			arr[INPUT.left]	 = obj_input2.arr[INPUT.left];
			arr[INPUT.left_press]	 = obj_input2.arr[INPUT.left_press];
			arr[INPUT.right] = obj_input2.arr[INPUT.right];
			arr[INPUT.right_press] = obj_input2.arr[INPUT.right_press];
			arr[INPUT.down]	 = obj_input2.arr[INPUT.down];
			arr[INPUT.up]	 = obj_input2.arr[INPUT.up];
			arr[INPUT.light] = obj_input2.arr[INPUT.light];
			arr[INPUT.heavy] = obj_input2.arr[INPUT.heavy];
			arr[INPUT.dodge] = obj_input2.arr[INPUT.dodge];
			arr[INPUT.special] = obj_input2.arr[INPUT.special];
		}
	

	
	}
	catch(e) {
		arr[INPUT.left]		= false;
		arr[INPUT.right]	= false;
		arr[INPUT.left_press]	= false;
		arr[INPUT.right_press]	= false;
		arr[INPUT.down]		= false;
		arr[INPUT.up]		= false;
		arr[INPUT.light]	= false;
		arr[INPUT.heavy]	= false;
		arr[INPUT.dodge]	= false;
		arr[INPUT.special]	= false;
	}
	
	function is_pressed(input){ return arr[input]; }

}


