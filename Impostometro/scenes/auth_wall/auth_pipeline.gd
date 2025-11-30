extends Control

var auth_settings_path = "user://settings/auth_settings.cfg"
var auth_settings = ConfigFile.new()


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	
	GlobalEventBus.add_user_signal("start_auth_pipeline", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	

func _on_connect_global_signals():
	pass 


func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando AuthPipeline signal"
	})
	GlobalEventBus.connect("start_auth_pipeline",_on_start_auth_pipeline)



## Append Auth Token
## @param payload datagram
func _on_start_auth_pipeline(payload: Dictionary) -> void:
#	Append auth token
	#var active_pipeline =  payload.get('pipeline',[])
	visible=true
	GlobalEventBus.emit_signal("debug_log",{"msg":"Respondendo ao pedido de iniciar auth pipeline"})	
	
func _enter_tree() -> void:
	print("Auth pipeline entered the tree")

func _exit_tree() -> void:
	print("Auth pipeline Exited the tree")
