extends Label

func _ready() -> void:
	GlobalEventBus.connect("append_to_selection_box", _on_append_to_selection_box)

func _on_append_to_selection_box(payload):
	text=payload
	
