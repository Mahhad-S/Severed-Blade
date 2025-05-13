function PlayerAnimateSprite(){
	//Update Sprite
	var _cardinalDir = round(direction/90);
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (_cardinalDir * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;

	//If animation would loop on next game step
	if (localFrame >= _totalFrames)
	{
		animationEnd = true;
		localFrame = 0;
	} else animationEnd = false;
}

/// Call this inside PlayerStateJump() every step
function PlayerAnimateJump() {
    // — (A) Init on first frame —
    if (!jumpInit) {
        // 1) Find current endpoint
        var ep = instance_position(x, y, obj_jump_end);
        if (ep != noone) {
            // 2) Find its partner by pairID
            var dest = noone;
            with (obj_jump_end) {
                if (pairID == ep.pairID && id != ep.id) {
                    dest = id;
                    break;
                }
            }
            if (dest != noone) {
                // store start/end (auto-align origin)
                jumpStartX = x;
                jumpStartY = y;
                jumpDestX  = dest.x + 6;
                jumpDestY  = dest.y + 12;
            }
        }

        // 3) Prepare animation
        direction    = input_dir;      // face jump dir
        sprite_index = spr_player_walk; // or spriteJump if you duplicated
        localFrame   = 0;
        animationEnd = false;

        // 4) Timing & arc parameters
        jumpTimer = 0;
        maxFrames = room_speed * 0.4;   // half-second jump
        arcHeight = 32;                 // peak; raise to clear taller walls

        jumpInit = true;
    }

    // — (B) Advance the jump each frame —
    jumpTimer++;
    var t = clamp(jumpTimer / maxFrames, 0, 1);

    // linear + parabolic lift
    var cx   = lerp(jumpStartX, jumpDestX, t);
    var cy   = lerp(jumpStartY, jumpDestY, t);
    var lift = arcHeight * 4 * t * (1 - t);

    x = cx;
    y = cy - lift;

    // — (C) Frame-by-frame sprite animation (4 directions) —
    var _cardinalDir = round(direction / 90);
    var _totalFrames = sprite_get_number(sprite_index) / 4;
    image_index      = localFrame + (_cardinalDir * _totalFrames);
    localFrame      += sprite_get_speed(sprite_index) / FRAME_RATE;

    if (localFrame >= _totalFrames) {
        animationEnd = true;
        localFrame   = 0;
    } else {
        animationEnd = false;
    }

    // — (D) Finish & return to Free —
    if (t >= 1) {
        x = jumpDestX;
        y = jumpDestY;
        jumpInit = false;
        state    = PlayerStateFree;
    }
}
