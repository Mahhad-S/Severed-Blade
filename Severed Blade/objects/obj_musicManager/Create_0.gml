/// InitAudioManager (run once at game start or in a persistent controller obj)

global.masterVolume      = 1;
global.musicVolume       = 0.25;
global.sfxVolume         = 1;

global.songInstance      = noone;
global.songAsset         = noone;
global.targetSongAsset   = noone;
global.endFadeOutTime    = 0;
global.startFadeInTime   = 0;
global.fadeInInstVol     = 1;

global.fadeOutInstances  = array_create(0);
global.fadeOutInstVol    = array_create(0);
global.fadeOutInstTime   = array_create(0);
