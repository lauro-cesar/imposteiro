extends GridContainer


func _ready() -> void:
	GlobalEventBus.connect("append_to_options_box",_on_append_to_options_box)

func _on_append_to_options_box(payload:Dictionary):
	pass
