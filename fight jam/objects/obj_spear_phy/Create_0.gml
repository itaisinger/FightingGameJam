is_echo = false;
floor_y = 849;

function apply_phy(){
	physics_apply_impulse(x, y, xadd*2, yadd*2.5);
	//physics_apply_torque(10000);
	phy_angular_velocity = 700;
}
function sound(){
	if(abs(phy_speed_y)>1 and alarm[0] <= 0){
		play_sfx(sfx_spear,,,[0.8,1.2],map_value(abs(phy_speed_y) + abs(phy_speed_x),0,5,0,2));
		alarm[0] = 10;
	}
}
	
step_delay = obj_game.step_delay;
step_delay_remain = 0;