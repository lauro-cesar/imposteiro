extends Label


func _on_update_total_acertos_label(payload: Dictionary) -> void:
	text = str(payload.get('value','0'))

func _ready() -> void:	
	GlobalEventBus.connect("update_total_acertos_label", _on_update_total_acertos_label)
	#call_deferred("emit_signal", "emit_label_updates", {})
