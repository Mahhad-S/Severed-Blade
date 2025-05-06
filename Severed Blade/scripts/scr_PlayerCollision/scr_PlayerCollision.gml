function PlayerCollision(){
	var _collision = false;
	
	//Horizontal Tiles
	if (tilemap_get_at_pixel(collisionMap, x + xspd + sign(xspd), y)) || instance_place(x, y + yspd + sign(yspd), obj_statue) || instance_place(x + xspd + sign(xspd), y, obj_mushroom)
	{
		x -= x mod TILE_SIZE;
		if (sign(xspd) == 1) {x += TILE_SIZE - 1;}
		xspd = 0;
		_collision = true;

	}
	//Horizontal Move Commit 
	x += xspd;
	//Vertical Tiles
	if (tilemap_get_at_pixel(collisionMap, x, y + yspd + sign(yspd))) || instance_place(x, y + yspd + sign(yspd), obj_statue) || instance_place(x + xspd + sign(xspd), y, obj_mushroom)
	{
		y -= y mod TILE_SIZE;
		if (sign(yspd) == 1) {y += TILE_SIZE - 1};
		yspd = 0;
		_collision = true;
	}
	//Vertical Move Commit 
	y += yspd;
	
	return _collision;
}