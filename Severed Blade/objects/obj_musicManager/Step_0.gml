/// AudioManager_Step()

// 1) Compute live volume
var _finalVol = global.masterVolume * global.musicVolume;

// 2) Handle song change request
if (global.songAsset != global.targetSongAsset) {
    // queue fade‐out of the old
    if (audio_is_playing(global.songInstance)) {
        array_push(global.fadeOutInstances, global.songInstance);
        array_push(global.fadeOutInstVol,    global.fadeInInstVol);
        array_push(global.fadeOutInstTime,   global.endFadeOutTime);
    }
    // once queue empty, start the new
    if (array_length(global.fadeOutInstances) == 0 && audio_exists(global.targetSongAsset)) {
        global.songInstance   = audio_play_sound(global.targetSongAsset, 4, true);
        audio_sound_gain(global.songInstance, 0, 0);
        global.fadeInInstVol  = 0;
        global.songAsset      = global.targetSongAsset;
    }
}

// 3) Fade in the current song
if (audio_is_playing(global.songInstance)) {
    if (global.startFadeInTime > 0) {
        global.fadeInInstVol = min(1, global.fadeInInstVol + 1 / global.startFadeInTime);
    } else {
        global.fadeInInstVol = 1;
    }
    audio_sound_gain(global.songInstance, global.fadeInInstVol * _finalVol, 0);
}

// 4) Fade out old songs
for (var i = array_length(global.fadeOutInstances) - 1; i >= 0; i--) {
    if (global.fadeOutInstTime[i] > 0) {
        global.fadeOutInstVol[i] = max(0, global.fadeOutInstVol[i] - 1/global.fadeOutInstTime[i]);
    } else {
        global.fadeOutInstVol[i] = 0;
    }
    audio_sound_gain(
        global.fadeOutInstances[i],
        global.fadeOutInstVol[i] * _finalVol,
        0
    );
    if (global.fadeOutInstVol[i] <= 0) {
        audio_stop_sound(global.fadeOutInstances[i]);
        array_delete(global.fadeOutInstances, i, 1);
        array_delete(global.fadeOutInstVol,    i, 1);
        array_delete(global.fadeOutInstTime,   i, 1);
    }
}
