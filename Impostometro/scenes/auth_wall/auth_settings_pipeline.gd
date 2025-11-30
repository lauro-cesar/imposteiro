extends Control
var auth_settings_path = "user://settings/auth_settings.cfg"
var auth_settings = ConfigFile.new()
var auth_settings_data:Dictionary = {}

func _on_create_new_auth_settings():
	auth_settings.clear()
	auth_settings.set_value("AUTH","auth_token","no_token")
	auth_settings.save(auth_settings_path)


func _on_append_auth_token(payload: Dictionary) -> void:
	pass 


func _on_append_auth_settings(payload: Dictionary) -> void:	
	var active_pipeline = payload.get('pipeline',[])
	
	if FileAccess.file_exists(auth_settings_path):
		var load_status = auth_settings.load(auth_settings_path)
		if load_status != OK:
			_on_create_new_auth_settings()
	else:
		_on_create_new_auth_settings()
	
	
func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)
	GlobalEventBus.add_user_signal("append_auth_settings", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	

func _ready() -> void:
	_on_register_global_signals({"msg":"Registrando Global Signals for AuthSettings Pipeline"})
	GlobalEventBus.connect("append_auth_settings",_on_append_auth_settings)
