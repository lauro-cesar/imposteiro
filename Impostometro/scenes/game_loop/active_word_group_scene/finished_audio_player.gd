extends AudioStreamPlayer2D

func _on_play_results_msg_audio():	
	var success_audio_path = "res://assets/they_2.wav"
	GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":success_audio_path})
	
func _ready() -> void:
	GlobalEventBus.connect("play_results_msg_audio",_on_play_results_msg_audio)
	
