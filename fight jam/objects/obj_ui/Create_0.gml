/// @description Insert description here
// You can write your code in this editor

enum DEPTH{
	player = 0,
	vfx = -1,
}

arr_players = [];
image = 0;
cd = 0;
echo_shake_remain = [0,0];
hp_shake_remain = [0,0];
echo_shakex = [[0,0],[0,0]];
echo_shakey = [[0,0],[0,0]];
hp_shakex = [0,0];
hp_shakey = [0,0];

function set_players(players_arr){
	arr_players[0] = players_arr[0];
	arr_players[1] = players_arr[1];
}

announce_text = "";
function set_announce_text(text)
{
	announce_text = text;
}
function shake_echo(p1)
{
	echo_shake_remain[p1] = min(15,echo_shake_remain[p1]+8);
}
function shake_hp(p1,amount)
{
	hp_shake_remain[p1] = min(10,hp_shake_remain[p1]+amount);
}
depth = -y;