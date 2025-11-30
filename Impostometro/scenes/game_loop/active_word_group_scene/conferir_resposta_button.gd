extends Button

func _on_latest_keyboard_input_value(payload: Dictionary) -> void:
	var latest_value = payload.value
	disabled = (latest_value.length() == 0)
	

func _ready() -> void:
	GlobalEventBus.emit_signal("debug_log",{
		"msg":"Registrando Conferir resposta button"
	})
	GlobalEventBus.connect("latest_keyboard_input_value", _on_latest_keyboard_input_value)
	#GlobalEventBus.connect("load_next_word", _on_load_next_word)

func _on_pressed() -> void:
	GlobalEventBus.emit_signal("debug_log",{
		"msg":"Conferir resposta clicado"
	})
	GlobalEventBus.emit_signal("conferir_resposta",{})
