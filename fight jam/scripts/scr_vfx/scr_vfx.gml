function create_vfx(_x,_y,asset,_xscale=1,_yscale=1,_angle=0,_fade_out=0){
	if(is_array(asset))
		asset = array_random(asset);
		
	return instance_create_depth(_x,_y,DEPTH.vfx,obj_vfx,{sprite_index: asset, image_xscale: _xscale, image_yscale: _yscale, image_angle: _angle, fade_out: _fade_out});
}

enum VFX{
	run,
	hit,
	hit_strong,
	parry,
	land,
	crash,
	
	hit_josh,

	hit_fire,
	hit_ice,
}

global.vfx_shuffles = [];
global.vfx_shuffles[VFX.run]		= [vfx_run_white,vfx_run_white_1,vfx_run_white_2];
global.vfx_shuffles[VFX.hit]		= [vfx_hit];
global.vfx_shuffles[VFX.hit_strong] = [vfx_hit_strong];