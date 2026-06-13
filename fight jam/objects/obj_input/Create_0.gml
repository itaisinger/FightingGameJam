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
buffer_amount = 5;

//binds

keybinds[INPUT.left]	= [ord("A"),vk_left,	"left"]
keybinds[INPUT.right]	= [ord("D"),vk_right,	"right"]
keybinds[INPUT.up]		= [ord("W"),vk_up,		"up"]
keybinds[INPUT.down]	= [ord("S"),vk_down,	"down"]
keybinds[INPUT.light]	= [ord("J"),vk_numpad4,	"light"]
keybinds[INPUT.heavy]	= [ord("K"),vk_numpad5,	"heavy"]
keybinds[INPUT.dodge]	= [ord("L"),vk_numpad6,	"dodge"]
keybinds[INPUT.echo]	= [vk_lshift,vk_numpad0,"echo"]


