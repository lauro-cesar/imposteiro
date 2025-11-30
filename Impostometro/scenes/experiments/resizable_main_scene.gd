extends Control



func _ready() -> void:
	GlobalEventBus.connect("show_keyboard",_on_show_leyboard)
	GlobalEventBus.connect("hide_keyboard",_on_hide_leyboard)
	
func _on_show_leyboard(payload):
	$HBoxContainer/OnscreenKeyboard._show_keyboard()
	
func _on_hide_leyboard(payload):
	$HBoxContainer/OnscreenKeyboard._hide_keyboard()
	
