extends Button


func _on_pressed() -> void:
	GlobalEventBus.emit_signal("download_groups_collection",{})
