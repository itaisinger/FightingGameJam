/// @description Insert description here
// You can write your code in this editor
if(keyboard_check_pressed(ord("R"))) game_restart();
if(keyboard_check_pressed(ord("B"))) active = !active;
if(keyboard_check_pressed(ord("T"))){
	with(obj_character){
		x = mouse_x;
		y = mouse_y;
	}
}
if(keyboard_check_pressed(ord("H"))) with(obj_character) echo_charges_remain++;
if(keyboard_check_pressed(ord("Z"))) with(obj_character) hp *= 0.5;
//if(keyboard_check_pressed(ord("L"))) with(obj_fighter) hit(1,8,12,irandom_range(20,120),30,true);
