for(var i=0;i<2;i++){
arr[i][INPUT.left]	 = 0;
arr[i][INPUT.right] = 0;
arr[i][INPUT.up]	 =0;
arr[i][INPUT.down]	 = 0;
arr[i][INPUT.light] =0;
arr[i][INPUT.heavy] = 0;
arr[i][INPUT.dodge] = 0;
arr[i][INPUT.echo] = 0;
}
padindex =[0,1];
axis=[0,0];


//binds
if(!file_exists("keybinds.json"))
{
	keybinds[INPUT.left]	= [ord("A"),vk_left,	"left"]
	keybinds[INPUT.right]	= [ord("D"),vk_right,	"right"]
	keybinds[INPUT.up]		= [ord("W"),vk_up,		"up"]
	keybinds[INPUT.down]	= [ord("S"),vk_down,	"down"]
	keybinds[INPUT.light]	= [ord("J"),vk_numpad4,	"light"]
	keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5,	"heavy"]
	keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6,	"dodge"]
	keybinds[INPUT.echo]	= [vk_lshift,vk_numpad0,"echo"]

	var _json = json_stringify(keybinds,1)
	var _file = file_text_open_write("keybinds.json")
	file_text_write_string(_file,_json);
	file_text_close(_file);
}
else
{
	var _file = file_text_open_read("keybinds.json");
	var _json = "";

	while (!file_text_eof(_file))
	{
		_json += file_text_read_string(_file);
	    file_text_readln(_file);
	}
	
	keybinds = json_parse(_json);
}

keys = {};
keys.enter = vk_enter
keys.shift = vk_shift;
keys.lshift = vk_lshift;
keys.space = vk_space;
keys.control = vk_control;
keys.alt = vk_alt;
keys.lalt = vk_lalt;
keys.numpad0 = vk_numpad0;
keys.numpad1 = vk_numpad1;
keys.numpad2 = vk_numpad2;
keys.numpad3 = vk_numpad3;
keys.numpad4 = vk_numpad4;
keys.numpad5 = vk_numpad5;
keys.numpad6 = vk_numpad6;
keys.numpad7 = vk_numpad7;
keys.numpad8 = vk_numpad8;
keys.numpad9 = vk_numpad9;
keys.arrow_right = vk_right;
keys.arrow_left = vk_left;
keys.arrow_up = vk_up;
keys.arrow_down = vk_down;
chars = "qwertyuiop[]asdfghjkl;'zxcvbnm,./"
for(var i=0; i < string_length(chars); i++)
	keys[$ string_char_at(chars,i)] = ord(string_char_at(chars,i))
	
var _json = json_stringify(keys,1)
var _file = file_text_open_write("keys values.json")
file_text_write_string(_file,_json);
file_text_close(_file);