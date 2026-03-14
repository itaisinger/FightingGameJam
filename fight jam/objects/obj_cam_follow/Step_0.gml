/// @description Insert description here
// You can write your code in this editor
var _sum = 0, _num = 0;
with(obj_fighter){
	_sum += x;
	_num++;
}

var _dest = _sum/_num;

x = approach(x,5,_dest);
x = lerp(x,_dest,0.05);