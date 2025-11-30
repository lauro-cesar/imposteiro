extends PanelContainer


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	

func _on_close_countdown(payload: Dictionary) -> void:
	visible=false



func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando CountDown container"
	})
	visible=false
	#GlobalEventBus.connect("debug_log",_on_debug_log)
	#GlobalEventBus.connect("error_log",_on_error_log)
	#GlobalEventBus.connect("hide_logger_overlay",_on_hide_logger_overlay)
	GlobalEventBus.connect("close_countdown",_on_close_countdown)
	#GlobalEventBus.emit_signal("close_countdown",{})
	#GlobalEventBus.emit_signal("load_next_word",{})s
	
		
		
