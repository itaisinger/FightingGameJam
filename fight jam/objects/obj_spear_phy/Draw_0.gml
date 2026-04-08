var _shadow_w = map_value(abs(y-floor_y),0,400,1,1.5) * 2.3*dcos(phy_rotation);
var _shadow_a = map_value(200-abs(y-floor_y),0,400,0.1,0.2);
draw_sprite_ext(spr_fighter_shadow,0,x,floor_y,_shadow_w,0.3,0,c_white,_shadow_a);
if(is_echo) image_alpha = ECHO_ALPHA;
draw_self()
