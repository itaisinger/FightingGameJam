/// @description Insert description here
// You can write your code in this 

voice = VinylPlayFadeIn("ost",false,0.5,0.2);
var _length = VinylGetLength(voice);
call_later(_length-5,time_source_units_seconds,method(self,play_ost))

function play_ost(){
	log("playing ost")
	if(room != rm_match) return;
	VinylFadeOut(voice,0.2);
	voice = VinylPlayFadeIn("ost",false,0.5,0.2);
	var _length = VinylGetLength(voice);
	call_later(_length - 5,time_source_units_seconds,method(self,play_ost))
}