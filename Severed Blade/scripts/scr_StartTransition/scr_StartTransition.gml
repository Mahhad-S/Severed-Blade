function start_transition() {
    if (!instance_exists(obj_Transition)) {
        global.targetRoom = targetRoom;
        global.targetX = targetX;
        global.targetY = targetY;
        global.targetDirection = obj_player.direction;
        with (obj_player) state = PlayerStateTransition;
        RoomTransition(TRANS_TYPE.SLIDE, targetRoom);
        instance_destroy();
        instance_destroy(obj_gameController);
        instance_destroy(obj_UI);
    }
}
