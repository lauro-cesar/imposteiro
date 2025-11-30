extends AudioStreamPlayer2D

func _on_play_fail_msg_audio():
	var success_audio_path = "res://assets/they_2.wav"
	GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":success_audio_path})
	GlobalEventBus.emit_signal("after_fail_success_msg",{})

func _ready() -> void:
	GlobalEventBus.connect("play_fail_msg_audio",_on_play_fail_msg_audio)
