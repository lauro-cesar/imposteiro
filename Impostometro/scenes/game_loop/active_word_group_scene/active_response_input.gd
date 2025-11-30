extends Label

func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)		


func _on_latest_keyboard_input_value(payload: Dictionary) -> void:
	var next_value = payload.get('value','')	
	#GlobalEventBus.emit_signal("set_play_active_word_button_visibility",{"state":(next_value.length() == 0)})	
	#GlobalEventBus.emit_signal("debug_log",{"msg":"Next Value: {0}".format([next_value])})
	#text=next_value

func _on_load_next_word(payload: Dictionary) -> void:
	pass
	
func _on_update_latest_input_value_label(payload: Dictionary) -> void:
	var next_value = payload.get('value','')
	GlobalEventBus.emit_signal("debug_log",{"msg":"Next Value: {0}".format([next_value])})
	text=next_value
	
func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Active response label"
	})
	GlobalEventBus.connect("update_latest_input_value_label", _on_update_latest_input_value_label)
	GlobalEventBus.connect("load_next_word", _on_load_next_word)


	
