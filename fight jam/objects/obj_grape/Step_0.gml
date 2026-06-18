
var _state_prev = state;
event_inherited()
if(is_grounded()) fly_mult = 1;
if(state != _state_prev) part_emitter_enable(part_active,emitter_active,false);

mask_index = sprite_index
var _w = 64;
var _x = dir == 1 ? bbox_right : bbox_left;
var _y = bbox_top
part_emitter_region(part_passive,emitter_passive, _x-_w/2,_x+_w/2, _y-_w/2,_y+_w/2,ps_shape_ellipse,ps_distr_gaussian);
_w = 24
part_emitter_region(part_active,emitter_active, _x-_w/2,_x+_w/2, _y-_w/2,_y+_w/2,ps_shape_ellipse,ps_distr_gaussian);

mask_index = hurtbox;