function approach(val,spd,dest){
	if(val == dest) return dest;
	
	if (val > dest) return max(val-spd,dest);
	if (val < dest) return min(val+spd,dest);
}
function draw_set_all(alpha=1,color=c_white,font=font_main,halign=fa_left,valign=fa_top)
{
	draw_set_alpha(alpha);
	draw_set_color(color);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(font);
}
function draw_reset()
{
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}