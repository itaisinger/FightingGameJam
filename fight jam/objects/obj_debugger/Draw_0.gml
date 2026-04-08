if(live_call()) return live_result;

if(!active) exit;

physics_world_draw_debug(phy_debug_render_shapes)

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_character) draw_sprite_ext(hurtbox,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
with(obj_hitbox) draw_self();
draw_set_font(font_announce_small)

try{ 
	with(obj_character) draw_text(x,y-100,string(combo_counter));
	mask_index = obj_character.mask_index;
	vars = [
	"state: " + string(obj_character.state),
	"sides: " + string(obj_character.input.is_pressed(INPUT.left)) + ", "  + string(obj_character.input.is_pressed(INPUT.right)),
	"diff: " + string(obj_character.input.is_pressed(INPUT.right) - obj_character.input.is_pressed(INPUT.right)),
	"xadd: " + string(obj_character.xadd),
	"charges: " + string(obj_character.echo_charges_remain),
	"stun_remain: " + string(obj_character.stun_remain),
	"pos: " + string(obj_character.x) + "," + string(obj_character.y),
	"rot: " + string(obj_spear_phy.phy_rotation) + ", " + string(dcos(obj_spear_phy.phy_rotation))
	]
	//vars = [];
	//var input = obj_fighter.input;
	//for(var i=0; i < array_length(input.arr); i++){
	//	vars[i] = input.arr[i];
	//}
	log("rot: " + string(obj_spear_phy.phy_rotation) + ", " + string(dcos(obj_spear_phy.phy_rotation)))
}
catch(a){vars=[];}


draw_set_all(1,c_white,font_main,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_text(25,25 + string_height("G")*i, vars[i]);
}

draw_reset();