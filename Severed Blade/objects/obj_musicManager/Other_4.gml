if room == rm_title 
{
	set_song_ingame(sng_title, 60, 0);
}

if room == rm_overworld_2
{
	set_song_ingame(sng_overworld, 60, 2*60);
}

if room == rm_Osara || room == rm_Hyongo || room == rm_Toga 
|| room == rm_nagato_armorshop || room == rm_nagato_itemshop || room == rm_nagato_weaponshop
{
	set_song_ingame(sng_nagata, 2*60, 2*60);
}

if room == rm_caveofrebirth_1 || room == rm_caveofrebirth_2 || room == rm_caveofrebirth_3 || room == rm_caveofrebirth_4
{
	set_song_ingame(sng_dungeons, 2*60, 2*60);
}