if(!keyboard_check_pressed(vk_space)) exit;

with(obj_hit_overlay) instance_destroy();
with instance_create_depth(mouse_x,mouse_y,0,obj_hit_overlay)
	set(mouse_x,mouse_y,irandom_range(8,13));