extends PanelContainer

func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	



func _on_after_click():
	visible=false
	GlobalEventBus.emit_signal("after_show_success_msg",{})

func _on_show_success_msg(payload: Dictionary) -> void:	
	visible=true
	GlobalEventBus.emit_signal("play_success_msg_audio")
	await get_tree().create_timer(0.5).timeout
	visible=false
	GlobalEventBus.emit_signal("after_show_success_msg",{})


func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Success MSG container"
	})
	visible=false
	#GlobalEventBus.connect("debug_log",_on_debug_log)
	#GlobalEventBus.connect("error_log",_on_error_log)
	#GlobalEventBus.connect("hide_logger_overlay",_on_hide_logger_overlay)
	GlobalEventBus.connect("show_success_msg",_on_show_success_msg)
	
