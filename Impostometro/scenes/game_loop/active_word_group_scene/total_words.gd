extends Label

func _on_update_total_words_label(payload: Dictionary) -> void:		
	text = str(payload.get('value','1'))

func emit_label_updates(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("emit_label_updates",{})
	

func _ready() -> void:	
	GlobalEventBus.emit_signal("debug_log",{
		"msg":"Registrando Total Words label"
	})
	GlobalEventBus.connect("update_total_words_label", _on_update_total_words_label)
	call_deferred("emit_label_updates",{})
	
	
	
