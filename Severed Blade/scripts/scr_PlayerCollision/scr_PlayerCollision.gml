function PlayerCollision(){
	var _collision = false;
	var _entityList = ds_list_create();

	// --- Horizontal Tiles ---
	if (tilemap_get_at_pixel(collisionMap, x + xspd + sign(xspd), y)) {
		
		x -= x mod TILE_SIZE;
		if (sign(xspd) == 1) { x += TILE_SIZE - 1; }
		xspd = 0;
		_collision = true;
	}
	
	//Horizontal Entities
	var _entityCount = instance_position_list(x + xspd, y, obj_entity, _entityList, false);
	var _snapX = x;
	while (_entityCount > 0) {
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entityCollision = true) {
			//Move as close as we can
			if (sign(xspd) == -1) _snapX = _entityCheck.bbox_right;
			if (sign(xspd) != -1) _snapX = _entityCheck.bbox_left - 1;
			x = _snapX;
			xspd = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	
	// Horizontal Move Commit 
	x += xspd;
	
	//Clear list between axis
	ds_list_clear(_entityList)

	// --- Vertical Tiles ---
	if (tilemap_get_at_pixel(collisionMap, x, y + yspd + sign(yspd))) {
		
		y -= y mod TILE_SIZE;
		if (sign(yspd) == 1) { y += TILE_SIZE - 1; }
		yspd = 0;
		_collision = true;
	}
	
	//Vertical Entities
	var _entityCount = instance_position_list(x, y + yspd, obj_entity, _entityList, false);
	var _snapY = y;
	while (_entityCount > 0) {
		var _entityCheck = _entityList[| 0];
		if (_entityCheck.entityCollision = true) {
			//Move as close as we can
			if (sign(yspd) == -1) _snapY = _entityCheck.bbox_bottom;
			if (sign(yspd != -1)) _snapY = _entityCheck.bbox_top - 1;
			y = _snapY;
			yspd = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	
	// Vertical Move Commit 
	y += yspd;
	
	ds_list_destroy(_entityList);
	
	return _collision;
}
