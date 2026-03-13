/// @description collide and register hits
var _cols = ds_list_create();
var _num = instance_place_list(x,y,obj_fighter,_cols,false);

for(var i=0; i < _num; i++){
	var _col = _cols[|i];
	
	//is it an unhit nme?
	if(_col.is_p1 != parent.is_p1 and !array_contains(arr_hits,_col)){
		
		//hit
		_col.hit(damage,knockback_x,knockback_y,stun_duration,hitpause,is_launcher);
		
		//remember target
		array_insert(arr_hits,0,_col);
		
		//give echo charge
		if(array_length(arr_hits) == 1 and give_echo_charge){
			parent.give_echo();
			parent.image_speed = 1.5;
		}
		
		//hitpause parent
		parent.hitpause_remain = hitpause/2;
		
		//sfx
		audio_play_sound(sfx_hit,0,0,1.5)
	}
		
		
}

ds_list_destroy(_cols)