function RoomToAreaName(_room){
	switch(_room) {
		case rm_overworld_2: return "The Overworld"; break;
		case rm_Toga: return "The Toga"; break;
		case rm_Hyongo: return "The Hyongo"; break;
		case rm_Osara: return "The Osara"; break;
		case rm_nagato_armorshop: return "The Nagato Armorshop"; break;
		case rm_nagato_weaponshop: return "The Nagato Weaponshop"; break;
		case rm_nagato_itemshop: return "The Nagato Itemshop"; break;
		default: return "Unknown Area"; break;
	}
}