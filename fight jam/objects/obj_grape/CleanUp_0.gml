/// @description Insert description here
// You can write your code in this editor
//destroying it here gives troubles, do it in a bit.
//call_later(1,time_source_units_frames,function(){
	part_system_destroy(part_active);
	part_system_destroy(part_passive);
	part_destroyed = true;
//});