function set_sfx_ingame(_soundAsset, _volumeScale = 1, _shouldLoop = false){
	/// scr_play_sfx(_soundAsset, _volScale = 1, _shouldLoop = false)
	/// @arg0  Audio asset (e.g. sfx_jump)
	/// @arg1  [0..1] per-effect volume scale
	/// @arg2  Boolean: loop the sound?
	var soundAsset = argument0;
	var volScale   = argument_count > 1 ? argument1 : 1;
	var shouldLoop = argument_count > 2 ? argument2 : false;

	// clamp to [0..1]
	volScale = clamp(volScale, 0, 1);

	// compute final gain from master & SFX settings
	var finalVol = global.masterVolume * global.sfxVolume * volScale;

	// play the sound (priority = 1 here, change if you need)
	// audio_play_sound(asset, priority, loop)
	var inst = audio_play_sound(soundAsset, 1, shouldLoop);

	// immediately set its volume: audio_sound_gain(instance, gain, time)
	audio_sound_gain(inst, finalVol, 0);

	return inst;
}