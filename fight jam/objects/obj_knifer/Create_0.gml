// Inherit the parent event
event_inherited();


max_hp = 80;
hp = max_hp;
ground_fric *= 0.7
slide_fric *= 0.8
walkspd = 9;
landing_lag = 3;

name = "JOHNNY DREX"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_knifer_idle;
//states_sprites[STATES.jump_squat]	= spr_skate_jump_squat;
//states_sprites[STATES.walk]			= spr_skate_walk;
//states_sprites[STATES.light]		= spr_skate_light;
//states_sprites[STATES.heavy]		= spr_skate_heavy;
//states_sprites[STATES.air]			= spr_skate_air;
//states_sprites[STATES.echo]			= spr_skate_echo;
//states_sprites[STATES.dodge]		= spr_skate_dodge;
//states_sprites[STATES.stun]			= spr_skater_hurt;
//states_sprites[STATES.air_stun]		= spr_skater_hurt;
//states_sprites[STATES.dead]			= spr_fighter_dead;
//states_sprites[STATES.parry]		= spr_skate_parry;
//states_sprites[STATES.teleport]		= spr_skater_tp;
//states_sprites[STATES.special]		= spr_skate_special;
//states_sprites[STATES.land]			= spr_skate_land;
//states_sprites[STATES.air_light]	= spr_skate_air_light;
//states_sprites[STATES.air_heavy]	= spr_skate_air_heavy;
//states_sprites[STATES.air_special]	= spr_skate_air_special;

hurtbox = spr_knifer_idle;
//states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= spr_knifer_idle;
//states_hurtboxes[STATES.jump_squat]	= hurtbox_skate_jump_squat;
//states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
//states_hurtboxes[STATES.light]		= hurtbox_skate_light;
//states_hurtboxes[STATES.heavy]		= hurtbox_skate_heavy;
//states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
//states_hurtboxes[STATES.echo]		= hurtbox_skate_echo;
//states_hurtboxes[STATES.dodge]		= hurtbox_skate_dodge;
//states_hurtboxes[STATES.stun]		= hurtbox_skater_hurt;
//states_hurtboxes[STATES.air_stun]	= hurtbox_skater_hurt;
//states_hurtboxes[STATES.dead]		= hurtbox_fighter_dead;
//states_hurtboxes[STATES.parry]		= hurtbox_skate_parry;
//states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
//states_hurtboxes[STATES.special]	= hurtbox_skate_special;
//states_hurtboxes[STATES.land]		= hurtbox_skate_land;
//states_hurtboxes[STATES.air_light]	= hurtbox_skate_air_light;
//states_hurtboxes[STATES.air_heavy]	= hurtbox_skate_air_heavy;
//states_hurtboxes[STATES.air_special]= hurtbox_skate_air_special;

image_xscale = 1;
image_yscale = 1;

function create_butterflies(margin){
	for(var xx=bbox_left; xx <= bbox_right; xx += margin)
	{
		for(var yy=bbox_top; yy <= bbox_bottom; yy += margin)
		{
			var _inst = instance_create_depth(xx,yy,depth-1,obj_butterfly);
			_inst.dir = xx >= x ? 1 : -1;
			_inst._create();
		}
	}
}

function teleport(delta)
{
	create_butterflies(3);
	x += delta;
	create_butterflies(15);
}