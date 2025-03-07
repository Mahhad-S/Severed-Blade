var _enemy_damage = obj_battle_enemy.data.damage * random_range(0.7, 1.2);
obj_battle_player.data.hp -= _enemy_damage;

enemy_turn = 0;