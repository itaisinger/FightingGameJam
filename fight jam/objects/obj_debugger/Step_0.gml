/// @description Insert description here
// You can write your code in this editor
if(live_call()) return live_result;
if(keyboard_check_pressed(ord("B"))) active = !active;


if(active){
if(keyboard_check_pressed(ord("H"))) with(obj_character) echo_charges_remain++;
if(keyboard_check_pressed(ord("Z"))) with(obj_character) hp *= 0.5;
if(keyboard_check_pressed(ord("X"))) with(obj_character) hp *= 2;
if(keyboard_check_pressed(ord("O"))) with(obj_ost) stop();

if(keyboard_check_pressed(ord("R"))) game_restart();

}

if(keyboard_check_pressed(ord("T"))){
	with(obj_knifer){
		teleport(dir*250);
	}
}
if(keyboard_check_pressed(ord("P"))){
	with(obj_fighter){
		afterimage(5);
	}
}
//if(keyboard_check_pressed(ord("L"))) with(obj_fighter) hit(1,8,12,irandom_range(20,120),30,true);
