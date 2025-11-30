extends ProgressBar


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	
	
func _on_set_contdown_value(payload: Dictionary) -> void:
	if value < 1.0:
		pass
		#GlobalEventBus.emit_signal("close_countdown",{})
	else:
		value = payload.value
		
func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Countdown_progress"
	})	
	GlobalEventBus.connect("set_contdown_value",_on_set_contdown_value)
