enum INPUT{
	//the order here matters, make sure up until max all are "real" inputs.
	left,
	right,
	up,
	down,
	light,
	heavy,
	dodge,
	echo,
	
	max,
	special,
	left_press,
	right_press,
	up_press,
	down_press,
	heavy_down,
	light_down,

}

function FrameInput(P1) constructor{
	
	try{
		arr[INPUT.left_press]	= obj_input.arr[P1][INPUT.left_press];
		arr[INPUT.up_press]		= obj_input.arr[P1][INPUT.up_press];
		arr[INPUT.right_press]	= obj_input.arr[P1][INPUT.right_press];
		arr[INPUT.down_press]	= obj_input.arr[P1][INPUT.down_press];
		
		arr[INPUT.right]		= obj_input.arr[P1][INPUT.right];
		arr[INPUT.down]			= obj_input.arr[P1][INPUT.down];
		arr[INPUT.up]			= obj_input.arr[P1][INPUT.up];
		arr[INPUT.left]			= obj_input.arr[P1][INPUT.left];
		
		arr[INPUT.heavy]		= obj_input.arr[P1][INPUT.heavy];
		arr[INPUT.light]		= obj_input.arr[P1][INPUT.light];
		arr[INPUT.light_down]	= obj_input.arr[P1][INPUT.light_down];
		arr[INPUT.heavy_down]	= obj_input.arr[P1][INPUT.heavy_down];
		
		arr[INPUT.dodge]		= obj_input.arr[P1][INPUT.dodge];
		arr[INPUT.special]		= obj_input.arr[P1][INPUT.special];
		arr[INPUT.echo]			= obj_input.arr[P1][INPUT.echo];
	}
	catch(e) {
		arr[INPUT.left]			= false;
		arr[INPUT.right]		= false;
		arr[INPUT.down]			= false;
		arr[INPUT.up]			= false;
		
		arr[INPUT.right_press]	= false;
		arr[INPUT.left_press]	= false;
		arr[INPUT.down_press]	= false;
		arr[INPUT.up_press]		= false;
		
		arr[INPUT.light]		= false;
		arr[INPUT.light_down]	= false;
		arr[INPUT.heavy_down]	= false;
		arr[INPUT.heavy]		= false;
		arr[INPUT.dodge]		= false;
		arr[INPUT.special]		= false;
		arr[INPUT.echo]			= false;
	}
	
	function is_pressed(input){ return arr[input]; }
	function is_just_pressed(_input) { 
		    return arr[_input] >= 3;
		}
}

//default binds
global.def_keybinds[INPUT.left]		= [ord("A"),vk_left,	"left"]
global.def_keybinds[INPUT.right]	= [ord("D"),vk_right,	"right"]
global.def_keybinds[INPUT.up]		= [ord("W"),vk_up,		"up"]
global.def_keybinds[INPUT.down]		= [ord("S"),vk_down,	"down"]
global.def_keybinds[INPUT.light]	= [ord("J"),vk_numpad4,	"light"]
global.def_keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5,	"heavy"]
global.def_keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6,	"dodge"]
global.def_keybinds[INPUT.echo]		= [vk_lshift,vk_numpad0,"echo"]

global.user_keybinds[INPUT.left]	= [ord("A"),vk_left,	"left"]
global.user_keybinds[INPUT.right]	= [ord("D"),vk_right,	"right"]
global.user_keybinds[INPUT.up]		= [ord("W"),vk_up,		"up"]
global.user_keybinds[INPUT.down]	= [ord("S"),vk_down,	"down"]
global.user_keybinds[INPUT.light]	= [ord("J"),vk_numpad4,	"light"]
global.user_keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5,	"heavy"]
global.user_keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6,	"dodge"]
global.user_keybinds[INPUT.echo]	= [vk_lshift,vk_numpad0,"echo"]

//input keys names
function get_key_name(key)
{
	if(key >= array_length(global.keys_names)) return "Unknown";
	return global.keys_names[key];
}
for(var i = 0; i < 256; i++)
{
    global.keys_names[i] = "Unknown";
}
global.keys_names[vk_escape] = "Escape";
global.keys_names[vk_f1] = "F1";
global.keys_names[vk_f2] = "F2";
global.keys_names[vk_f3] = "F3";
global.keys_names[vk_f4] = "F4";
global.keys_names[vk_f5] = "F5";
global.keys_names[vk_f6] = "F6";
global.keys_names[vk_f7] = "F7";
global.keys_names[vk_f8] = "F8";
global.keys_names[vk_f9] = "F9";
global.keys_names[vk_f10] = "F10";
global.keys_names[vk_f11] = "F11";
global.keys_names[vk_f12] = "F12";
global.keys_names[vk_pause] = "Pause";
global.keys_names[192] = "Tilde(~)";
global.keys_names[ord("1")] = "1";
global.keys_names[ord("2")] = "2";
global.keys_names[ord("3")] = "3";
global.keys_names[ord("4")] = "4";
global.keys_names[ord("5")] = "5";
global.keys_names[ord("6")] = "6";
global.keys_names[ord("7")] = "7";
global.keys_names[ord("8")] = "8";
global.keys_names[ord("9")] = "9";
global.keys_names[ord("0")] = "0";
global.keys_names[189] = "Dash(-)";
global.keys_names[187] = "Equals(=)";
global.keys_names[vk_backspace] = "Backspace";
global.keys_names[ord("A")] = "A";
global.keys_names[ord("B")] = "B";
global.keys_names[ord("C")] = "C";
global.keys_names[ord("D")] = "D";
global.keys_names[ord("E")] = "E";
global.keys_names[ord("F")] = "F";
global.keys_names[ord("G")] = "G";
global.keys_names[ord("H")] = "H";
global.keys_names[ord("I")] = "I";
global.keys_names[ord("J")] = "J";
global.keys_names[ord("K")] = "K";
global.keys_names[ord("L")] = "L";
global.keys_names[ord("M")] = "M";
global.keys_names[ord("N")] = "N";
global.keys_names[ord("O")] = "O";
global.keys_names[ord("P")] = "P";
global.keys_names[ord("Q")] = "Q";
global.keys_names[ord("R")] = "R";
global.keys_names[ord("S")] = "S";
global.keys_names[ord("T")] = "T";
global.keys_names[ord("U")] = "U";
global.keys_names[ord("V")] = "V";
global.keys_names[ord("W")] = "W";
global.keys_names[ord("X")] = "X";
global.keys_names[ord("Y")] = "Y";
global.keys_names[ord("Z")] = "Z";
global.keys_names[219] = "L Bracket([)";
global.keys_names[221] = "R Bracket(])";
global.keys_names[220] = "Backslash(\\)";
global.keys_names[20] = "Capslock";
global.keys_names[186] = "Semi-Colon(;)";
global.keys_names[222] = "Apostrophe(')";
global.keys_names[vk_enter] = "Enter";
global.keys_names[vk_lshift] = "L Shift";
global.keys_names[vk_rshift] = "R Shift";
global.keys_names[vk_lcontrol] = "L Control";
global.keys_names[vk_rcontrol] = "R Control";
global.keys_names[vk_lalt] = "L Alt";
global.keys_names[vk_ralt] = "R Alt";
global.keys_names[188] = "Comma(,)";
global.keys_names[190] = "Period(.)";
global.keys_names[191] = "Slash(/)";
global.keys_names[vk_space] = "Spacebar";
global.keys_names[93] = "Apps";
global.keys_names[vk_insert] = "Insert";
global.keys_names[vk_home] = "Home";
global.keys_names[vk_pageup] = "Page Up";
global.keys_names[vk_delete] = "Delete";
global.keys_names[vk_end] = "End";
global.keys_names[vk_pagedown] = "Page Down";
global.keys_names[111] = "Numpad Slash(/)";
global.keys_names[106] = "Numpad Asterisk(*)";
global.keys_names[109] = "Numpad Dash(-)";
global.keys_names[vk_numpad0] = "Numpad 0";
global.keys_names[vk_numpad1] = "Numpad 1";
global.keys_names[vk_numpad2] = "Numpad 2";
global.keys_names[vk_numpad3] = "Numpad 3";
global.keys_names[vk_numpad4] = "Numpad 4";
global.keys_names[vk_numpad5] = "Numpad 5";
global.keys_names[vk_numpad6] = "Numpad 6";
global.keys_names[vk_numpad7] = "Numpad 7";
global.keys_names[vk_numpad8] = "Numpad 8";
global.keys_names[vk_numpad9] = "Numpad 9";
global.keys_names[110] = "Numpad Period(.)";
global.keys_names[107] = "Numpad Plus(+)";
global.keys_names[vk_left] = "Left Arrow";
global.keys_names[vk_right] = "Right Arrow";
global.keys_names[vk_up] = "Up Arrow";
global.keys_names[vk_down] = "Down Arrow";