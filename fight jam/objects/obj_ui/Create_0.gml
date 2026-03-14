/// @description Insert description here
// You can write your code in this editor

enum DEPTH{
	player = 0,
}

arr_players = [];

function set_players(players_arr){
	arr_players[0] = players_arr[0];
	arr_players[1] = players_arr[1];
}

announce_text = "";
function set_announce_text(text)
{
	announce_text = text;
}