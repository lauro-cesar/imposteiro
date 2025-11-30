extends HBoxContainer

@export var key_button: PackedScene 
@export var key_container: PackedScene 

@export_file("*.json") var keys_file: String



func _ready() -> void:
	if keys_file != "":
		var file = FileAccess.open(keys_file, FileAccess.READ)
		if file:
			var text = file.get_as_text()
			var data = JSON.parse_string(text)
			if data != null:
				for payload in data:
					if payload.key_type == "key":
						var key_button_instance = key_button.instantiate()						
						key_button_instance.load_payload(payload)
						add_child(key_button_instance)
					else:
						var key_container_instance = key_container.instantiate()
						key_container_instance.load_payload(payload)
						add_child(key_container_instance)
						
