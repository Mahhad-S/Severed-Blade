//global volume control
global.masterVolume = 0;
global.musicVolume = 1;

//info for the song we are currently playing / trying to play
songInstance = noone;
songAsset = noone;
targetSongAsset = sng_overworld;
endFadeOutTime = 0; //how many frames to fade out the song currently playing
startFadeInTime = 0; //how many frames to fade in the new song
fadeInInstVol = 1; //the volume of songInstance