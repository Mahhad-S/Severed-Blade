function start_push(p){
	pushing = true;
    player_pusher = p;
    path_start(path_assigned, 2, path_action_stop, false); // Speed 2; don't loop
}