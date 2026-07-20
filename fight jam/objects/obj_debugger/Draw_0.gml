
if(!active) exit;

physics_world_draw_debug(phy_debug_render_shapes)

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_hitbox) draw_self();
draw_set_font(font_announce_small)


//draw_circle(obj_camera.x,obj_camera.y,20,0);
//try{ 
//	//with(obj_character) draw_text(x,y-100,string(image_speed));
//	//with(obj_character) draw_text(x,y-100,string(obj_character.combo_counter));
//	vars = [
//	"DEBUG MENU CONTROLS:",
//	"R - restart",
//	"Z - hp/2",
//	"X - hp*2",
//	"O - toggle outlines",
//	"H - give echo charges",
//	]
	
//	draw_set_all(1,c_white,font_main,fa_left,fa_top);

//	for (var i = 0; i < array_length(vars); ++i) {
//		draw_text(obj_camera._camx + 25,obj_camera._camy + 25 + string_height("G")*i, vars[i]);
//	}
//	draw_reset();


//}
//catch(a){vars=[];}




