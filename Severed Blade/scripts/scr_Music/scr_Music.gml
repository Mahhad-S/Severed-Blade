function set_song_ingame(_song, _fadeOut = 0, _fadeIn = 0) {
    global.targetSongAsset = _song;
    global.endFadeOutTime  = _fadeOut;
    global.startFadeInTime = _fadeIn;
}