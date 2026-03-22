/// @description Insert description here
// You can write your code in this editor
if(!active) exit;

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_character) draw_sprite_ext(hurtbox,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
with(obj_hitbox) draw_self();
draw_set_font(font_announce_small)
with(obj_gameplay_object) draw_text(x,y-100,combo_counter_damage);

try{ 
	mask_index = obj_character.mask_index;
	for(var i=0; i < array_length(obj_input.arr); i++)
	{
		vars[i] = obj_input.arr[i];
	}
}
//try{ 
//	mask_index = obj_character.mask_index;
//	vars = [
//	"state: " + string(obj_character.state),
//	"sides: " + string(obj_character.input.is_pressed(INPUT.left)) + ", "  + string(obj_character.input.is_pressed(INPUT.right)),
//	"diff: " + string(obj_character.input.is_pressed(INPUT.right) - obj_character.input.is_pressed(INPUT.right)),
//	"xadd: " + string(obj_character.xadd),
//	"charges: " + string(obj_character.echo_charges_remain),
//	"stun_remain: " + string(obj_character.stun_remain),
//	"pos: " + string(obj_character.x) + "," + string(obj_character.y),
//	"keys: " + string(obj_input.arr[INPUT.light]) + ", " + string(obj_input.arr[INPUT.heavy]) + ", " + string(obj_input.arr[INPUT.special])
//	]
//}
catch(a){vars=[];}


draw_set_all(1,c_white,font_main,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_text(25,25 + string_height("G")*i, vars[i]);
}

draw_reset();