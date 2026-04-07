#macro OST_FADE 4
voice = -1;

function play_ost(){
	if(room != rm_match) return;
	VinylFadeOut(voice,0.2);
	voice = VinylPlayFadeIn("ost",false,1/OST_FADE,global.ost_vol);
	
	//scheduale next
	var _length = VinylGetLength(voice);
	alarm[0] = room_speed*(_length - OST_FADE)
	log("playing " + audio_get_name(VinylGetAsset(voice)) + ", length: " + string(_length));
}

play_ost();
