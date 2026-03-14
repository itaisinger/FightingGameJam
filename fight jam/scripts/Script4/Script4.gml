function create_hitbox(_hitbox_data){
	
	if(inst_hitbox != noone)
		instance_destroy(inst_hitbox)
	
	inst_hitbox = instance_create_depth(x,y,depth,obj_hitbox,_hitbox_data);
	inst_hitbox.dir = dir;
	inst_hitbox.image_xscale = dir;
	inst_hitbox.parent = self;
	
}