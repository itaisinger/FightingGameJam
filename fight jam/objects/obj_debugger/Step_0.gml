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
if(keyboard_check_pressed(ord("H"))) with(obj_fighter) hit(1,random_range(-10,10),random(5),irandom_range(20,120),15,false);
if(keyboard_check_pressed(ord("L"))) with(obj_fighter) hit(1,8,12,irandom_range(20,120),30,true);
