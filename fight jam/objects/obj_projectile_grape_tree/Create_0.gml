event_inherited();

hp = 5;
xadd = 0;
yadd = 0;
//image_yscale = 5;
//image_xscale = 2;
mask_index = hurtbox_spr;
death_vfx = -1;

life = room_speed * 2;
sfx = play_sfx(vines_climbing_done)

create_vfx(x,y,vfx_tree_spawn,3,3);

data = new HitboxData(hitbox_spr,5,60,3,0,9,0,0,0,,1);
parry = function(){
	life = life_max;
	is_p1 = !is_p1;
}

function reached_frame(index) //return true if this is the first frame that we reached this sub image.
{
	return (floor(image_index) == index and floor(image_index_prev) < index)
}