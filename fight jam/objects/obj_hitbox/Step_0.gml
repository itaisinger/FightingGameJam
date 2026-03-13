/// @description collide and register hits
if(!is_parry)
{
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
		
			//first hit effects
			if(array_length(arr_hits) == 1){
				
				//give echo charge
				if(give_echo_charge)
					parent.give_echo();
			
				parent.image_speed = hit_speedup;
				image_speed = hit_speedup;
				
				if(!parent.is_grounded()){
					parent.yadd *= 0.5
					parent.yadd -= parent.jumpforce_y * 0.2
				}
			}
		
			//hitpause parent
			parent.hitpause_remain = hitpause/2;
		
			//sfx
			audio_play_sound(sfx_hit,0,0,1.5)
		}
	}

	ds_list_destroy(_cols)
}
else
{
	var _cols = ds_list_create();
	var _num = instance_place_list(x,y,obj_hitbox,_cols,false);
	
	for(var i=0; i < _num; i++){
		var _col = _cols[|i];
	
		//is it an unhit nme?
		if(_col.parent.is_p1 != parent.is_p1 and !array_contains(arr_hits,_col)){
		
			//hit
			_col.parent.hit(damage,knockback_x,knockback_y,stun_duration,hitpause,is_launcher);
		
			//remember target
			array_insert(arr_hits,0,_col);
		
			//give echo charge
			if(array_length(arr_hits) == 1){
			
				if(give_echo_charge)
					parent.give_echo();
			
				parent.image_speed = hit_speedup;
				image_speed = hit_speedup;
			}
		
			//hitpause parent
			//parent.hitpause_remain = hitpause/2;
		
			//sfx
			audio_play_sound(sfx_hit,0,0,1.5)
		}
	}

	ds_list_destroy(_cols)
}