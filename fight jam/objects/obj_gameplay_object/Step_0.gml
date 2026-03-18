//FRAME DELAY
if(step_delay_remain > 0)
{
	step_delay_remain--;
	image_index -= (sprite_get_speed(sprite_index)/room_speed) * image_speed;
	exit;
}
else
{
	step_delay_remain = step_delay;
}