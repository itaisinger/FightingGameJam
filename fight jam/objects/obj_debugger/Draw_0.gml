if(live_call()) return live_result;

if(!active) exit;

physics_world_draw_debug(phy_debug_render_shapes)

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_hitbox) draw_self();
draw_set_font(font_announce_small)

try{ 
	//with(obj_character) draw_text(x,y-100,string(image_speed));
	with(obj_character) draw_text(x,y-100,string(obj_character.combo_counter));
	mask_index = obj_character.mask_index;
	vars = [
	"state: " + string(obj_character.image_speed),
	"sides: " + string(obj_character.input.is_pressed(INPUT.left)) + ", "  + string(obj_character.input.is_pressed(INPUT.right)),
	"echo: " + string(obj_character.input.is_pressed(INPUT.right) - obj_character.input.is_pressed(INPUT.right)),
	"xadd: " + string(obj_character.xadd),
	"xdest: " + string(obj_camera.xdest),
	"zoom: " + string(obj_camera.zoom),
	]
}
catch(a){vars=[];}


draw_set_all(1,c_white,font_main,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_text(25,25 + string_height("G")*i, vars[i]);
}

draw_reset();