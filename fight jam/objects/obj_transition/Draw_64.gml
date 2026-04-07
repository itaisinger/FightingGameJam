if(state == TRANS_STATES.off) exit;

var _w = display_get_gui_width();

var _ch = animcurve_get_channel(cur_trans,0);
var _val = min(1,animcurve_channel_evaluate(_ch,trans_prec));

draw_sprite_ext(spr_transition,0,(_w/2)+(_w/2)*(1-_val),0,1,1,0,0,1);
draw_sprite_ext(spr_transition,1,(_w/2)*_val,0,1,1,0,0,1);