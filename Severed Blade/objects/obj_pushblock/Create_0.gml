// Create event of obj_pushblock
// Define direction enum
enum Dir {
    RIGHT = 0,
    UP = 1,
    LEFT = 2,
    DOWN = 3
}

xspd = 0;
yspd = 0;
moveSpd = 0.2;
faceDir = Dir.RIGHT;

gridSpace = 16;
startPointX = x;
startPointY = y;
targetX = x;
targetY = y;

sliding = false;
