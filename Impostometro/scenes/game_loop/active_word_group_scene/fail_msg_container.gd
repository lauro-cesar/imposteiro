extends PanelContainer

func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	


func _on_after_click():
	visible=false
	GlobalEventBus.emit_signal("after_show_fail_msg",{})
	
	
func _on_show_fail_msg(payload: Dictionary) -> void:
	visible=true
	
	
	GlobalEventBus.emit_signal("play_fail_msg_audio")
	$VBoxContainer/correto_container_value/correta_value.text = payload.active_word_upper
	$VBoxContainer/errado_container_value/errado_value.text = payload.last_text_upper
	if payload.show_results:
		$VBoxContainer/next_action_button_container/action_button.text ="Ver resultados"
	
	
	



func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Fail MSG container"
	})
	visible=false
	#GlobalEventBus.connect("debug_log",_on_debug_log)
	#GlobalEventBus.connect("error_log",_on_error_log)
	#GlobalEventBus.connect("hide_logger_overlay",_on_hide_logger_overlay)
	GlobalEventBus.connect("show_fail_msg",_on_show_fail_msg)
	
