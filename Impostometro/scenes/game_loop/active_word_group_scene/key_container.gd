extends PanelContainer
var key_payload: Dictionary


func load_payload(payload: Dictionary) -> void:
	key_payload= payload
	size_flags_stretch_ratio=payload.key_size
	
func _ready() -> void:
	pass 
