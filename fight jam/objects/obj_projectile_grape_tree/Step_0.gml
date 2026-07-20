event_inherited();
image_index = min(image_index,image_number-0.5);
if(reached_frame(3))
{
	inst_hitbox.update_data(new HitboxData(hitbox_spr,2,40,3,0,5,0,0,0,,1));
}
image_index_prev = image_index;
xadd = 0;

with(object_index)
{
	if(abs(x-other.x) < 30 and self != other)
		instance_destroy();
}