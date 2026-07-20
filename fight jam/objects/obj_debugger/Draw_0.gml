
if(!active) exit;

physics_world_draw_debug(phy_debug_render_shapes)

draw_set_color(c_red)
with(all) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_set_color(c_white)

with(obj_hitbox) draw_self();
with(obj_hurtbox) draw_self();
