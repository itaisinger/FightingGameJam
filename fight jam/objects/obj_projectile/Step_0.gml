// move
x += xadd * dir;
y += yadd;

//hitbox
with(inst_hitbox){
	x = other.x;	
	y = other.y;
	dir = other.dir;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	image_speed = other.image_speed;
	image_index = other.image_index;
}

// lifetime
life--;
if (life <= 0){
	destroy();	
}