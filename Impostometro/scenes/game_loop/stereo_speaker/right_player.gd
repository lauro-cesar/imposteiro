extends AudioStreamPlayer

func _ready() -> void:
	GlobalEventBus.connect("play_audio",_on_play_audio)

func _on_play_audio():
	pass
	#print("Ignoring")
	#play()

	
