extends Button


func _on_show_logs_pressed():
	GlobalEventBus.emit_signal("show_logger_overlay")
