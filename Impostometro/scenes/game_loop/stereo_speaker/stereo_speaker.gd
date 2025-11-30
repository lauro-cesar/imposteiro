extends Control





func _on_play_wav_from_bytes(payload: Dictionary):
	var bytes_from_file = payload.get("bytes")
	var audio_stream = AudioStreamWAV.load_from_buffer(bytes_from_file)
	$master_player.stream = audio_stream	
	$master_player.play()

	
func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)		
	GlobalEventBus.add_user_signal("play_wav_from_bytes", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	


func _ready() -> void:
	_on_register_global_signals({
		"msg":"Iniciando audio player"
	})
	#
	GlobalEventBus.connect("play_wav_from_bytes",_on_play_wav_from_bytes)
	
