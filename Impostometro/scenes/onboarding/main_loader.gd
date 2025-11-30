extends PanelContainer

func _on_register_global_signals(payload: Dictionary) -> void:	
	GlobalEventBus.emit_signal("debug_log",payload)		
	

func _on_hide_main_loader(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",{"msg":"Running _on_hide_main_loader"})	
	visible=false

func _on_show_main_loader(payload: Dictionary) -> void:
	var parent = get_parent()
	if parent:
		parent.move_child.call_deferred(self, parent.get_child_count() - 1)
		
	GlobalEventBus.emit_signal("debug_log",{"msg":"Running _on_show_main_loader"})
	visible=true

func _ready() -> void:	
	_on_register_global_signals({
		"msg":"Registrando Main loader"
	})	
	GlobalEventBus.connect("hide_main_loader",_on_hide_main_loader)	
	GlobalEventBus.connect("show_main_loader",_on_show_main_loader)	
	
