extends Label


func _on_update_active_index_word_label(payload: Dictionary) -> void:
	text = str(payload.get('value','0'))

func _ready() -> void:	
	GlobalEventBus.connect("update_active_index_word_label", _on_update_active_index_word_label)
