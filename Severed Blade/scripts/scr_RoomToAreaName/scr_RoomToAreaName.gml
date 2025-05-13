function RoomToAreaName(_room){
	switch(_room) {
		case rm_overworld_2: return "The Overworld"; break;
		case rm_Toga: return "The Toga"; break;
		case rm_Hyongo: return "The Hyongo"; break;
		case rm_Osara: return "The Osara"; break;
		case rm_nagato_armorshop: return "The Nagato Armorshop"; break;
		case rm_nagato_weaponshop: return "The Nagato Weaponshop"; break;
		case rm_nagato_itemshop: return "The Nagato Itemshop"; break;
		case rm_caveofrebirth_1: return "Cave of Rebirth 1"; break;
		case rm_caveofrebirth_2: return "Cave of Rebirth 2"; break;
		case rm_caveofrebirth_3: return "Cave of Rebirth 3"; break;
		case rm_caveofrebirth_4: return "Cave of Rebirth 4"; break;
		case rm_palace1: return "Palace 1"; break;
		case rm_palace2: return "Palace 2"; break;
		case rm_palace3: return "Palace 3"; break;
		default: return "Unknown Area"; break;
	}
}