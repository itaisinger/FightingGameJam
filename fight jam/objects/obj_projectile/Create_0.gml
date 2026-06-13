
parent = noone;
dir = 1;
is_p1 = false;

life = 120;

data = new HitboxData(hitbox_spr,5,10,3,3,2,0,0,0,function(){hit(2)},,,vfx_ice_explosion);
death_vfx = vfx_ice_explosion;

_yshake = 0;
_xshake = 0;
shake_remain = 0;

hp = 1;

xadd = 10;
yadd = 0;

//hitbox checks for these.
jumpforce_y = 0;
function is_grounded(){return false;} 

function hit(damage,knockx=0,knocky=0,stun=0,hitpause=0,is_launch=0,is_parry=0){
	
	hp = max(hp-damage,0);
	
	//die
	if(hp == 0) {
		instance_destroy();
		exit;
	}
	
	//shake
	shake_remain = damage;
}

function start(){
	inst_hurtbox = instance_create_depth(x,y,depth,obj_hurtbox);
	inst_hurtbox.parent = self;
	mask_index = hurtbox_spr;

	inst_hitbox = instance_create_depth(x,y,depth,obj_hitbox,data);
	inst_hitbox.parent = self;
	inst_hitbox.dir = dir;
	inst_hitbox.loop = 1;

}