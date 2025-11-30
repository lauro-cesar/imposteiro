extends Button

var payload: Dictionary = {}


func _on_pressed() -> void:
	var base64_audio_data = payload.get('audio_data',false)
	var bytes: PackedByteArray = Marshalls.base64_to_raw(base64_audio_data)
	GlobalEventBus.emit_signal("play_wav_from_bytes",{"bytes":bytes})
	
