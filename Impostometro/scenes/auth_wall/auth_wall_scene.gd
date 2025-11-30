extends Control

func on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)


func _ready() -> void:	
	on_register_global_signals({"msg":"Registrando Global Signals for AuthWall"})
	GlobalEventBus.emit_signal("debug_log",{"msg":"AuthWall Ready"})
	GlobalEventBus.emit_signal("show_logger_overlay")
	GlobalEventBus.emit_signal("start_auth_pipeline",{})



	
func _enter_tree() -> void:
	pass 
func _exit_tree() -> void:
	pass 
