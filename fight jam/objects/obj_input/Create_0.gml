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
keybinds[INPUT.left]	= global.user_keybinds[INPUT.left]
keybinds[INPUT.right]	= global.user_keybinds[INPUT.right]
keybinds[INPUT.up]		= global.user_keybinds[INPUT.up]
keybinds[INPUT.down]	= global.user_keybinds[INPUT.down]
keybinds[INPUT.light]	= global.user_keybinds[INPUT.light]
keybinds[INPUT.heavy]	= global.user_keybinds[INPUT.heavy]
keybinds[INPUT.dodge]	= global.user_keybinds[INPUT.dodge]
keybinds[INPUT.echo]	= global.user_keybinds[INPUT.echo]


