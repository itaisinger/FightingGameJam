display_set_gui_size(480, 270);

var _w = room_width;
var _h = room_height;
//var _w = display_get_gui_width();
//var _h = display_get_gui_height();

switch(room)
{
	case rm_menu:
		
		//draw_sprite(spr_menu_fire,0,_w*0.4,_h*1.1)

		draw_set_all(1,c_white,font_main,fa_center,fa_middle);
		if(wave(-1,1,2) > -0.5) {
			draw_set_color(c_black)
			draw_set_alpha(0.3)
			var _off = 5
			draw_text(_w/2-_off,_h*0.6+_off,"press enter to start");
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_text(_w/2,_h*0.6,"press enter to start");
			
		}
		
		if(cd-- <= 0){
			cd = 20;
			image++
		}
		
		draw_sprite_ext(spr_announce_spark	,image,_w/2+20,_h*0.3,4,4,0,c_white,1)
		draw_sprite_ext(spr_announce_spark_2,image,_w/2-20,_h*0.3,4,4,0,c_white,1)
		draw_sprite_ext(spr_title,0,_w*0.5,_h*0.3,1,1,0,c_white,1)
		
		//portraits
		draw_sprite_ext(arr_characters[chosen_characters[1]].sprite,0,_w * 0.2, _h,-1,1, 0,c_white,1);
		draw_sprite_ext(arr_characters[chosen_characters[0]].sprite,0,_w * 0.8, _h, 1,1, 0,c_white,1);
		
		//names
		var	_c1 = c_black
		var _c2 = #9E0B0F
		draw_set_all(1,c_white,font_announce_small,fa_center,fa_middle)
		
		draw_text_ext_transformed_colour(_w*0.2,_h*0.425,arr_characters[chosen_characters[1]].name,_h*0.04,_w*0.5,2,2,0,_c1,_c1,_c2,_c2,1)
		draw_text_ext_transformed_colour(_w*0.8,_h*0.425,arr_characters[chosen_characters[0]].name,_h*0.04,_w*0.5,2,2,0,_c1,_c1,_c2,_c2,1)
		
		_input[0] = new FrameInput(true);
		_input[1] = new FrameInput(false);
		
		draw_set_all(1,c_white,font_main,fa_left,fa_top);
		for(var i=0; i < array_length(_input[0].arr); i++){
			//draw_text(20,20+string_height("G")*1.1*i,_input[0].arr[i]);
		}
		
		//fire
		for(var i=0; i < sprite_get_number(spr_menu_fire); i++){
			//draw_sprite_ext(spr_menu_fire,i,_w*0.6,_h*1.3,1,1,0,c_white,0.4)
		}
		
		//draw_sprite(spr_keyboard,0,_w/2,_h*0.8);
		
	break;
	
}