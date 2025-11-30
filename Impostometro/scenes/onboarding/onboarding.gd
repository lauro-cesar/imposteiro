extends Control

var window = JavaScriptBridge.get_interface("window")
var _on_before_close_web_page = JavaScriptBridge.create_callback(_before_close_web_page)
func _before_close_web_page(args):
	pass 

var _on_before_back_web_page = JavaScriptBridge.create_callback(_before_back_web_page)
	
func _before_back_web_page(args):
	pass



func _on_reset_cache_and_reload() -> void:
	if OS.has_feature('web'):
		window.reset_cache_and_reload() 
	
func _on_register_global_signals(payload: Dictionary) -> void:	
	GlobalEventBus.emit_signal("debug_log",payload)	


func _ready() -> void:	
	_on_register_global_signals({
		"msg":"Registrando Onboardings"
	})

	GlobalEventBus.set_version_number()
