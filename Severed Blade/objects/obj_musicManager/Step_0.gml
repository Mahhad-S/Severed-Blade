var _finalVol = global.masterVolume * global.musicVolume;

//Play the target song
if songAsset != targetSongAsset {
	if audio_exists(targetSongAsset) {
		//Play the song and store its instance in a variable
		songInstance = audio_play_sound(sng_overworld, 4, true);
	
		//Start the song's volume at 0
		audio_sound_gain(songInstance, 0, 0);
		fadeInInstVol = 0;
	}
	
	//Set the songAsset to match the targetSongAsset
	songAsset = targetSongAsset;
}

//Volume control
//Main song volume
if audio_is_playing(songInstance) {
	//Fade the song in
	if startFadeInTime > 0 {
		if fadeInInstVol < 1 { fadeInInstVol += 1 / startFadeInTime; } else fadeInInstVol = 1;
	} else { //Immediately start the song if the fade in time is 0 frame
		fadeInInstVol = 1	
	}
	
	//Actually set the gain
	audio_sound_gain(songInstance, fadeInInstVol * _finalVol, 0);
}