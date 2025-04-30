flash = max(0, flash-0.05); 
fric = 0.05; 

// Magnetise 
if (instance_exists(obj_player))
{
	var _px = obj_player.x;
	var _py = obj_player.y;
	var _dist = point_distance(x,y,_px,_py);
	
	if (_dist < 12) // meagnet radiçus 	
	{	
		spd += 0.25;
		direction = point_direction(x,y, _px, _py);
		spd = min(spd,3);
		fric = 0;
		if (_dist < 4) // collect radius 
		{
			if (collectScriptArg != -1) 
			{
				script_execute(collectScript, collectScriptArg)
			}
			else if (collectScript != -1)
			{
				script_execute(collectScript)
			}
			instance_destroy()
		}
	}
}

x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);
spd = max(spd-fric, 0); 
depth = -bbox_bottom; 