function set_sfx_ingame(_soundAsset, _volumeScale = 1, _shouldLoop = false) {
	var soundAsset = _soundAsset;
	var volScale   = clamp(_volumeScale, 0, 1);
	var shouldLoop = _shouldLoop;

	var finalVol = global.masterVolume * global.sfxVolume * volScale;
	var inst = audio_play_sound(soundAsset, 1, shouldLoop);
	audio_sound_gain(inst, finalVol, 0);

	// Only track if it's a looping SFX
	if (shouldLoop) {
		array_push(global.loopingSFXInstances, [inst, volScale]); // Store volume scale too
	}

	return inst;
}
