extends Button


func _on_pressed() -> void:
	GlobalEventBus.emit_signal("close_countdown",{})
