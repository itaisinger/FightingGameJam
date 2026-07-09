arr_hits = [];	//save hits to not rehit the same target
loop = 0;
stop = false;

update_data = function(data){
	var _names = struct_get_names(data);
	for(var i=0; i < array_length(_names); i++)
	{
		variable_instance_set(self,_names[i],struct_get(data,_names[i]));
	}
}