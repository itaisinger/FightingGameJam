// Inherit the parent event
event_inherited();

max_hp *= 1.2;

xadd = 0;
yadd = 0;
walkspd = 7;
grav = 0.6;
stun_grav = grav * 0.4;
air_drift_spd = walkspd*0.03;
max_air_spd = walkspd * 10;
air_fric = 0.05;
stun_air_fric = air_fric * 0.25;
ground_fric = 1;
slide_fric = ground_fric * 0.4;	//used to slide when entering states that slide

jumpforce_y = 12;
name = "SPYKE"
win_sfx = sfx_johnny_wins;

states_sprites[STATES.idle]			= spr_spyke_idle;
states_sprites[STATES.jump_squat]	= spr_spyke_jump_squat;
states_sprites[STATES.walk]			= spr_spyke_walk;
states_sprites[STATES.light]		= spr_spyke_light;
states_sprites[STATES.heavy]		= spr_spyke_heavy;
states_sprites[STATES.air]			= spr_spyke_air;
states_sprites[STATES.echo]			= spr_spyke_echo;
//states_sprites[STATES.dodge]		= spr_spyke_dodge;
states_sprites[STATES.stun]			= spr_spyke_hurt;
states_sprites[STATES.air_stun]		= spr_spyke_hurt;
states_sprites[STATES.dead]			= spr_fighter_dead;
states_sprites[STATES.parry]		= spr_spyke_parry;
states_sprites[STATES.teleport]		= spr_spyke_teleport;
states_sprites[STATES.special]		= spr_spyke_special;
states_sprites[STATES.land]			= spr_spyke_land;
states_sprites[STATES.air_light]	= spr_spyke_air_light;
states_sprites[STATES.air_heavy]	= spr_spyke_air_heavy;
//states_sprites[STATES.air_special]	= spr_spyke_air_special;

hurtbox = spr_knifer_idle;
//states_hurtboxes = [];
states_hurtboxes[STATES.idle]		= spr_knifer_idle;
//states_hurtboxes[STATES.jump_squat]	= hurtbox_spyke_jump_squat;
//states_hurtboxes[STATES.walk]		= hurtbox_fighter_walk;
//states_hurtboxes[STATES.light]		= hurtbox_spyke_light;
//states_hurtboxes[STATES.heavy]		= hurtbox_spyke_heavy;
//states_hurtboxes[STATES.air]		= hurtbox_fighter_air;
//states_hurtboxes[STATES.echo]		= hurtbox_spyke_echo;
//states_hurtboxes[STATES.dodge]		= hurtbox_spyke_dodge;
//states_hurtboxes[STATES.stun]		= hurtbox_spyker_hurt;
//states_hurtboxes[STATES.air_stun]	= hurtbox_spyker_hurt;
//states_hurtboxes[STATES.dead]		= hurtbox_fighter_dead;
//states_hurtboxes[STATES.parry]		= hurtbox_spyke_parry;
//states_hurtboxes[STATES.teleport]	= hurtbox_fighter_tp;
//states_hurtboxes[STATES.special]	= hurtbox_spyke_special;
//states_hurtboxes[STATES.land]		= hurtbox_spyke_land;
//states_hurtboxes[STATES.air_light]	= hurtbox_spyke_air_light;
//states_hurtboxes[STATES.air_heavy]	= hurtbox_spyke_air_heavy;
//states_hurtboxes[STATES.air_special]= hurtbox_spyke_air_special;