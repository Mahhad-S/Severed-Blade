function LoadGame(_slot){
	global.gameSaveSlot = _slot;
	var _file = "save" + string(global.gameSaveSlot) + ".sav";
	if (file_exists(_file)) {
		//Load the game data
		var _json = LoadJSONFromFile(_file);
		
		//global variables
		global.party[0].hp = _json[? "playerHealth"];
		global.party[0].hpMax = _json[? "playerHealthMax"];
		global.party[0].ep = _json[? "playerEP"];
		global.party[0].epMax = _json[? "playerEPMax"];
		global.party[0].Level = _json[? "playerLevel"];
		global.party[0].STR = _json[? "playerSTR"];
		global.party[0].INT = _json[? "playerINT"];
		global.party[0].CON = _json[? "playerCON"];
		global.party[0].SPD = _json[? "playerSPD"];
		global.party[0].currentXP = _json[? "playerXP"];
		global.party[0].xpNeededToLevelUp = _json[? "playerXPNeeded"];
		global.party[0].equipment.head = _json[? "playerHead"];
		global.party[0].equipment.body = _json[? "playerBody"];
		global.party[0].equipment.weapon = _json[? "playerWeapon"];
		
		global.playerXLoad = _json[? "playerX"];
		global.playerYLoad = _json[? "playerY"];
		
		global.fire_magic_unlocked = _json[? "FireMagicUnlocked"]
		
		// ——— Rebuild inventory array from the saved list ———
	    var invList = _json[? "playerInventory"];
	    if (ds_exists(invList, ds_type_list)) {
	        var invSize = ds_list_size(invList);
	        global.inventory = array_create(invSize, 0);
	        for (var j = 0; j < invSize; j++) {
	            global.inventory[j] = ds_list_find_value(invList, j);
	        }
	        ds_list_destroy(invList);
	    } else {
	        // if somehow missing, start empty
	        global.inventory = [];
	    }
		
		//lists to arrays
		/*
		for (var i = 0; i < ITEM.TYPE_COUNT; i++) {
			global.playerItemUnlock[i] = _json[? "playerItemUnlocked"][| i];	
		}
		*/
		
		//Quest data
		//ds_map_copy(global.questStatus, _json[? "questStatus"]);
		
		//Room
		RoomTransition(TRANS_TYPE.SLIDE, _json[? "room"]);
		ds_map_destroy(_json);
		
		return true;
	} else {
		show_debug_message("no save in this slot");
		return false;
	}
}

function LoadJSONFromFile(_filename) {
	var _buffer = buffer_load(_filename);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _json = json_decode(_string);
	return _json;
}