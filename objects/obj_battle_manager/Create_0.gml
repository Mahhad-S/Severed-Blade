enemy_turn = 0;
damage_to_enemy = 0;

player_attack = function (_damage) {
	damage_to_enemy = _damage;
	enemy_turn = 1;
	alarm[0] = 40;
}