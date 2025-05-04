//idle
// idle state
if (!sliding) {
	startPointX = x;
	startPointY = y;
	xspd = 0;
	yspd = 0;
}

if (sliding) {
	var _realDir = faceDir * 90;
	
	var _targetXDist = lengthdir_x(gridSpace, _realDir);
	var _targetYDist = lengthdir_y(gridSpace, _realDir);
	targetX = startPointX + _targetXDist;
	targetY = startPointY + _targetYDist;
	
	var _targetDist = point_distance(x, y, targetX, targetY);
	var _finalSpd = min(moveSpd, _targetDist);
	xspd = lengthdir_x(_finalSpd, _realDir);
	yspd = lengthdir_y(_finalSpd, _realDir);
	
	// Cancel movement if wall is in the way
	if (place_meeting(targetX, targetY, obj_wall)) {
		xspd = 0;
		yspd = 0;
		sliding = false;
	}
}

x += xspd;
y += yspd;

// Stop movement when destination is reached
if (xspd == 0 && yspd == 0) {
	sliding = false;
}

depth = -bbox_bottom;
