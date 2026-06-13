event_inherited();

xadd = 0;
yadd = 0;
image_yscale = 5;
image_xscale = 2;
mask_index = hurtbox_spr;

life = room_speed * 2;
sfx = play_sfx(vines_climbing_done)

create_vfx(x,y,vfx_tree_spawn,3,3);

data = new HitboxData(hitbox_spr,3,60,3,0,11,0,0,0,,1);
parry = function(){
	life = life_max;
	is_p1 = !is_p1;
}