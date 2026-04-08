is_echo = false;
floor_y = 849;

function apply_phy(dir=1,mult=1){
	physics_apply_impulse(x, y, xadd*2, yadd*2.5);
	phy_angular_velocity = 3500*dir*random_range(0.8,1.2)*mult;
	
	if(is_echo) phy_angular_velocity *= 0.7;
}
function sound(){
	if(abs(phy_speed_y)>0.3 and alarm[0] <= 0){
		play_sfx(sfx_spear,,,[0.8,1.2],map_value(abs(phy_speed_y) + abs(phy_speed_x),0,5,0,2));
		alarm[0] = 10;
	}
}

step_delay = obj_game.step_delay;
step_delay_remain = 0;