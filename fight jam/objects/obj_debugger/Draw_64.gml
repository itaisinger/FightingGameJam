
if(!active) exit;

try{ 
	//with(obj_character) draw_text(x,y-100,string(image_speed));
	//with(obj_character) draw_text(x,y-100,string(obj_character.combo_counter));
	vars = [
	"DEBUG MENU CONTROLS:",
	"R - restart",
	"Z - hp/2",
	"X - hp*2",
	"O - toggle outlines",
	"H - give echo charges",
	]
}
catch(a){vars=[];}


draw_set_all(1,c_white,font_debug,fa_left,fa_top);

for (var i = 0; i < array_length(vars); ++i) {
    draw_set_color(c_black);
	draw_text(4,4 + string_height("G")*i, vars[i]);
	draw_set_color(c_white);
    draw_text(5,5 + string_height("G")*i, vars[i]);
}

draw_reset();