extends LineEdit

func _ready() -> void:
	GlobalEventBus.emit_signal("append_to_selection_box","ios ready")
	Input.use_accumulated_input =true
	
	
func _on_text_changed(new_text):
	GlobalEventBus.emit_signal("append_to_selection_box",new_text)
