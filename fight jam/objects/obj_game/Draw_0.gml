display_set_gui_size(480, 270);

var _w = room_width;
var _h = room_height;

switch(room)
{
	case rm_menu:
		
		draw_set_all(1,c_white,font_main,fa_center,fa_middle);
		if(wave(-1,1,2) > -0.5) {
			draw_set_color(c_black)
			draw_set_alpha(0.3)
			var _off = 5
			draw_text(_w/2-_off,_h*0.6+_off,"press ECHO to confirm\npress T for tutorial\npress I to rebind controls");
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_text(_w/2,_h*0.6,"press ECHO to confirm\npress T for tutorial\npress I to rebind controls");
		}
		
		if(cd-- <= 0){
			cd = 20;
			image++
		}
		
		draw_sprite_ext(spr_announce_spark	,image,_w/2+20,_h*0.3,4,4,0,c_white,1)
		draw_sprite_ext(spr_announce_spark_2,image,_w/2-20,_h*0.3,4,4,0,c_white,1)
		draw_sprite_ext(spr_title,0,_w*0.5,_h*0.3,1,1,0,c_white,1)
		
		/// portraits
		draw_sprite_ext(arr_characters[chosen_characters[1]].sprite,0,_w * 0.2, _h,-1,1, 0,c_white,1);
		draw_sprite_ext(arr_characters[chosen_characters[0]].sprite,0,_w * 0.8, _h, 1,1, 0,c_white,1);
		
		if(port_flash[0] + port_flash[1] > 0)
		{
			var _max_a = 0.6;
			var _spd = 0.02;
			shader_set(sh_sillouete);
			
			draw_sprite_ext(arr_characters[chosen_characters[1]].sprite,0,_w * 0.2, _h,-1,1, 0,c_white,port_flash[1]*_max_a);
			draw_sprite_ext(arr_characters[chosen_characters[0]].sprite,0,_w * 0.8, _h, 1,1, 0,c_white,port_flash[0]*_max_a);
			
			shader_reset();
			
			port_flash[0] = approach(port_flash[0],_spd,0);
			port_flash[1] = approach(port_flash[1],_spd,0);
		}
		
		/// names
		var	_c1 = c_black
		var _c2 = #930e12//#9E0B0F
		var _c2_ready = #F22318//#EE1C24
		draw_set_all(1,c_white,font_announce_small,fa_center,fa_middle)
		draw_set_valign(fa_middle);
		
		_s1 = lerp(_s1, 2 + player_is_confirmed[0] * 0.4, 0.15);
		_s2 = lerp(_s2, 2 + player_is_confirmed[1] * 0.4, 0.15);
		var _y1 = _h * 0.425 - string_height_ext(arr_characters[chosen_characters[1]].name, _h*0.04, _w*0.5) * (_s2-2)/2;
		var _y0 = _h * 0.425 - string_height_ext(arr_characters[chosen_characters[0]].name, _h*0.04, _w*0.5) * (_s1-2)/2;

		draw_text_ext_transformed_colour(_w*0.2,_y1,arr_characters[chosen_characters[1]].name,_h*0.04,_w*0.5,_s2,_s2,0,_c1,_c1,player_is_confirmed[1] ? _c2_ready : _c2, player_is_confirmed[1] ? _c2_ready : _c2,1)
		draw_text_ext_transformed_colour(_w*0.8,_y0,arr_characters[chosen_characters[0]].name,_h*0.04,_w*0.5,_s1,_s1,0,_c1,_c1,player_is_confirmed[0] ? _c2_ready : _c2, player_is_confirmed[0] ? _c2_ready : _c2,1)
		
		_input[0] = new FrameInput(true);
		_input[1] = new FrameInput(false);
		
		
	break;
	
}