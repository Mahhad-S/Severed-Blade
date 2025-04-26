function LoadGame(_slot){
	global.gameSaveSlot = _slot;
	var _file = "save" + string(global.gameSaveSlot) + ".sav";
	if (file_exists(_file)) {
		//Load the game data
		var _json = LoadJSONFromFile(_file);
		
		//global variables
		global.party[0].hp = _json[? "playerHealth"];
		//global.playerHealthMax = _json[? "playerHealthMax"];
		//global.playerMoney = _json[? "playerMoney"];
		//global.playerEquipped = _json[? "playerEquipped"];
		//global.playerHasAnyItems = _json[? "playerHasAnyItems"];
		global.playerXLoad = _json[? "playerX"];
		global.playerYLoad = _json[? "playerY"];
		
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