extends Control



func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.add_user_signal("show_logger_overlay")	
	GlobalEventBus.add_user_signal("hide_logger_overlay")	
	GlobalEventBus.add_user_signal("debug_log", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	
	GlobalEventBus.add_user_signal("error_log", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	


func _on_error_log(payload: Dictionary):
	$VBoxContainer/logs_container.current_tab=0
	$VBoxContainer/logs_container/error_logs_item_list.add_item(payload.get('msg',''))

func _on_debug_log(payload: Dictionary):
	$VBoxContainer/logs_container.current_tab=1
	$VBoxContainer/logs_container/debug_logs_item_list.add_item(payload.get('msg',''))
	
func _on_test_error_log_signal():
	GlobalEventBus.emit_signal("error_log",{"msg":"error log test.."})

func _on_test_debug_log_signal():
	GlobalEventBus.emit_signal("debug_log",{"msg":"debug log test.."})

func _on_show_logger_overlay():
	visible=true

func _on_hide_logger_overlay():
	visible=false 

func _ready() -> void:
	_on_register_global_signals({})
	GlobalEventBus.connect("debug_log",_on_debug_log)
	GlobalEventBus.connect("error_log",_on_error_log)
	GlobalEventBus.connect("hide_logger_overlay",_on_hide_logger_overlay)
	GlobalEventBus.connect("show_logger_overlay",_on_show_logger_overlay)
	
		

func _enter_tree() -> void:
	print("auth_wall entered the tree")


func _exit_tree() -> void:
	print("auth_wall Exited the tree")
