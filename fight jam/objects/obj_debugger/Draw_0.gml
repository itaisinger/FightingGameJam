/// @description Insert description here
// You can write your code in this editor
if(!active) exit;

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_fighter) draw_sprite_ext(hurtbox,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

try{ 
	mask_index = obj_fighter.mask_index;
	vars = [
	"state: " + string(obj_fighter.state),
	"sides: " + string(obj_fighter.input.is_pressed(INPUT.left)) + ", "  + string(obj_fighter.input.is_pressed(INPUT.right)),
	"diff: " + string(obj_fighter.input.is_pressed(INPUT.right) - obj_fighter.input.is_pressed(INPUT.right)),
	"xadd: " + string(obj_fighter.xadd),
	"charges: " + string(obj_fighter.echo_charges_remain),
	"hitpause: " + string(obj_fighter.hitpause_remain),
	"pos: " + string(obj_fighter.x) + "," + string(obj_fighter.y)
	]
}
catch(a){vars=[];}


draw_set_all(1,c_white,font_main,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_text(25,25 + string_height("G")*i, vars[i]);
}

draw_reset();