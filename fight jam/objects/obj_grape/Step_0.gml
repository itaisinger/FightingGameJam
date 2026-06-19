
var _state_prev = state;
event_inherited()
if(is_grounded()) fly_mult = 1;
if(state != _state_prev) part_set_enabled(true,false);
part_set_enabled(false,frog_remain <= 0);

mask_index = sprite_index
var _w = 110;
var _x = dir == 1 ? bbox_right : bbox_left;
var _y = bbox_top

part_emitter_region(part_passive,emitter_passive, _x-_w/2,_x+_w/2, _y-_w/2,_y+_w/2,ps_shape_ellipse,ps_distr_gaussian);
_w = 24
part_emitter_region(part_active,emitter_active, _x-_w/2,_x+_w/2, _y-_w/2,_y+_w/2,ps_shape_ellipse,ps_distr_gaussian);

var _spd = sqrt(xadd*xadd + yadd*yadd)/4;
var _dir = xadd == 0 ? 
	sign(yadd) * 90 : 
	(yadd == 0 ? 90 + sign(xadd) : darctan(-yadd/xadd));
part_type_speed(part_type_passive,		_spd,_spd,-0.05,0);
part_type_speed(part_type_active,		_spd,_spd,-0.05,0);
part_type_direction(part_type_passive,	_dir,_dir,0,0);
part_type_direction(part_type_active,	_dir,_dir,0,0);

mask_index = hurtbox;

//update particle systems
if(current_time % 3 == 0)
{
	part_system_update(part_active);
	part_system_update(part_passive);
}