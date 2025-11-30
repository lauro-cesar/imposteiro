extends AudioStreamPlayer



var paths_to_play: Array = []


func _on_play_wav_from_path(payload: Dictionary):	
	var file_path = payload.get('file_path', "res://assets/they_2.wav")	
	var bytes_from_file = FileAccess.get_file_as_bytes(file_path)
	var audio_stream = AudioStreamWAV.load_from_buffer(bytes_from_file)
	stream = audio_stream
	play()
	

func _ready() -> void:
	GlobalEventBus.connect("play_wav_from_path",_on_play_wav_from_path)


	
