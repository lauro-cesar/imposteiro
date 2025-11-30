extends VBoxContainer


func _ready() -> void:
	GlobalEventBus.emit_signal("debug_log",{
		"msg":"Registrando Lista de palavras para escutar"
	})	
	
	
	#GlobalEventBus.connect("dismiss_open_word_group", _on_dismiss_open_word_group)
	#GlobalEventBus.connect("close_countdown",_on_close_countdown)
	#GlobalEventBus.connect("load_next_word", _on_load_next_word)	
	#GlobalEventBus.connect("play_active_word", _on_play_active_word)
	#GlobalEventBus.connect("append_key", _on_append_key)
	#GlobalEventBus.connect("delete_all", _on_delete_all)
	#GlobalEventBus.connect("delete_last_key", _on_delete_last_key)
	
