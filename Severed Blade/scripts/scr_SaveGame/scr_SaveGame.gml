function SaveGame(){
	//Create Save Map
	var _map = ds_map_create();
	
	_map[? "room"] = room;
	_map[? "playerHealth"] = global.party[0].hp;
	_map[? "playerHealthMax"] = global.party[0].hpMax;
	_map[? "playerEP"] = global.party[0].ep;
	_map[? "playerEPMax"] = global.party[0].epMax;
	_map[? "playerLevel"] = global.party[0].Level;
	_map[? "playerSTR"] = global.party[0].STR;
	_map[? "playerINT"] = global.party[0].INT;
	_map[? "playerCON"] = global.party[0].CON;
	_map[? "playerSPD"] = global.party[0].SPD;
	_map[? "playerXP"] = global.party[0].currentXP;
	_map[? "playerXPNeeded"] = global.party[0].xpNeededToLevelUp;
	_map[? "playerHead"] = global.party[0].equipment.head;
	_map[? "playerBody"] = global.party[0].equipment.body;
	_map[? "playerWeapon"] = global.party[0].equipment.weapon;
	
	// ——— Save Inventory Array as a DS-list ———
    var invList = ds_list_create();
    for (var i = 0; i < array_length(global.inventory); i++) {
        ds_list_add(invList, global.inventory[i]);
    }
    _map[? "playerInventory"] = invList;
	
	if (instance_exists(obj_player)) {
	    _map[? "playerX"] = obj_player.x;
	    _map[? "playerY"] = obj_player.y;
	}
	
	//magic unlocks
	_map[? "FireMagicUnlocked"] = global.fire_magic_unlocked;
	
	//var _questMap = ds_map_create();
	//ds_map_copy(_questMap, global.questStatus);
	//ds_map_add_map(_map, "questStatus", _questMap);
	
	//Save all of this to a string
	var _string = json_encode(_map);
	SaveStringToFile("save" + string(global.gameSaveSlot) + ".sav", _string);
	show_debug_message(_string);
	
	//Nuke the data
	ds_map_destroy(_map);
	show_debug_message("Game saved!");
}

function SaveStringToFile(_filename, _string) {
		var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
		buffer_write (_buffer, buffer_string, _string);
		buffer_save(_buffer, _filename);
		buffer_delete(_buffer);
}