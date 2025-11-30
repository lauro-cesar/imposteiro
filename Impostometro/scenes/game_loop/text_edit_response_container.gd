extends TextEdit



func _on_text_changed():
	GlobalEventBus.emit_signal("append_to_selection_box",text)
