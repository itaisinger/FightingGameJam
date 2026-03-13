/// @description Insert description here
// You can write your code in this editor
if(keyboard_check_pressed(ord("R"))) game_restart();
if(keyboard_check_pressed(ord("B"))) active = !active;
if(keyboard_check_pressed(ord("T"))){
	with(obj_fighter){
		x = mouse_x;
		y = mouse_y;
	}
}