if(fade_out)
{
	var _prec = image_index / image_number
	image_alpha = map_value(1 - _prec, 0, 0.2, 0, 1);
}