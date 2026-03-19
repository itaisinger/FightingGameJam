/// @description collide and register hits
if(!is_parry)
{
	var _cols = ds_list_create();
	var _num = instance_place_list(x,y,obj_character,_cols,false);

	for(var i=0; i < _num; i++){
		var _col = _cols[|i];
	
		//is it an unhit nme?
		if(_col.is_p1 != parent.is_p1 and !array_contains(arr_hits,_col)){
		
			//hit
			_col.hit(damage,knockback_x*dir,knockback_y,stun_duration,hitpause,is_launcher);
		
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
					parent.yadd = min(0,parent.yadd)
					parent.yadd -= parent.jumpforce_y * 0.1;
				}
				
				//call
				func();
			}
		
			//hitpause parent
			parent.hitpause_remain = hitpause/2;
			
			//sfx
			var _gain = map_value(damage,3,15, 0.3,2);
			play_sfx(sfx_hit,0,0,[0.8,1.2],_gain)
			
			//vfx
			var _r = 10;
			var _x = (bbox_left+bbox_right+_col.bbox_left+_col.bbox_right)/4 + random_range(-_r,_r);
			var _y = (bbox_top+bbox_bottom+_col.bbox_top+_col.bbox_bottom)/4 + random_range(-_r,_r);
			var _size = map_value(damage,3,15, 0.6,2);
			create_vfx(_x,_y,_size,spr_hit,random_range(0,360));
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
		if(_col.parent.is_p1 != parent.is_p1 and !array_contains(arr_hits,_col) and !_col.is_parry){
		
			//hit
			var _nme = _col.parent;
			
			//vfx
			var _r = 10;
			var _x = (bbox_left+bbox_right+_col.bbox_left+_col.bbox_right)/4 + random_range(-_r,_r);
			var _y = (bbox_top+bbox_bottom+_col.bbox_top+_col.bbox_bottom)/4 + random_range(-_r,_r);
			create_vfx(_x,_y,1,spr_hit_parry,random_range(0,360));
			
			_col.parent.hit(damage,knockback_x,knockback_y,stun_duration,hitpause,false);
			_nme.xadd = 0;
			_nme.yadd = 0;
			//_nme.is_parried = true;
			
			//remember target
			array_insert(arr_hits,0,_col);
		
			//give echo charge
			if(array_length(arr_hits) == 1){
			
				if(give_echo_charge)
					parent.give_echo();
			
				with(parent) image_index = image_number - 0.5;
				
				//call 
				func();
			}
		
			//sfx
			play_sfx(sfx_parry,0,0,[0.9,1.1],1.5)
		}
	}

	ds_list_destroy(_cols)
}