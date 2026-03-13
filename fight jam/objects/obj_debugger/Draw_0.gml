/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)


try{ 
	vars = [
	"sides: " + string(obj_fighter.input.is_pressed(INPUT.left)) + ", "  + string(obj_fighter.input.is_pressed(INPUT.right)),
	"diff: " + string(obj_fighter.input.is_pressed(INPUT.right) - obj_fighter.input.is_pressed(INPUT.right)),
	"xadd: " + string(obj_fighter.xadd)
	]
}
catch(a){vars=[];}


draw_set_all(1,c_white,font_main,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_text(25,25 + string_height("G")*i, vars[i]);
}

draw_reset();