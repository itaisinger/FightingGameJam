var _app_spd = 0.01;
var _lerp_spd = 0.0;

switch(state)
{
	case TRANS_STATES.in:
		trans_prec = lerp(trans_prec,1,_lerp_spd)	
		trans_prec = approach(trans_prec,_app_spd,1)
		
		if(trans_prec >= 1){
			room_goto(target)
			state = TRANS_STATES.out;
		}
	break;
	//////////////////////
	case TRANS_STATES.out:
		trans_prec = lerp(trans_prec,0,_lerp_spd)	
		trans_prec = approach(trans_prec,_app_spd*2,0)
		
		if(trans_prec <= 0){
			state = TRANS_STATES.off;
		}
	break;
}