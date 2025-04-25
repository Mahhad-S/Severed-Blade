if room == rm_title 
{
	set_song_ingame(noone, 0, 0);
}

if room == rm_overworld_2
{
	set_song_ingame(sng_overworld, 60, 0);
}

if room == rm_Osara || room == rm_Hyongo || room == rm_Toga 
|| room == rm_nagato_armorshop || room == rm_nagato_itemshop || room == rm_nagato_weaponshop
{
	set_song_ingame(sng_nagata, 2*60, 2*60);
}