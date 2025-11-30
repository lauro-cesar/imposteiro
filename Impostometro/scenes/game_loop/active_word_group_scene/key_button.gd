extends Button

var key_payload: Dictionary
var is_focused: bool= false


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)		


func _on_pressed():	
	$keyboard_key_tap_sound.play()
	var event_name = key_payload.get('key_event_name','append_key')	
	GlobalEventBus.emit_signal(event_name,key_payload)
	GlobalEventBus.emit_signal("debug_log",{
		"msg":"Key pressed {0} EventName: {1}".format([key_payload.key_value,event_name])
	})
	

func load_payload(payload: Dictionary) -> void:
	key_payload= payload
	var size: Vector2 = custom_minimum_size
	custom_minimum_size.x = size.x * payload.key_size
	
	var default_icon = "res://assets/letter_svg/{0}_white.svg".format([payload.key_name.to_lower()])
	var key_icon_path =payload.get('key_icon_path',default_icon)
	
	if ResourceLoader.exists(key_icon_path, "Texture2D"):
		pass
		
	if key_icon_path == 'no_icon':
		text=key_payload.key_value
	else:
		var icon_texture: Texture2D = load(key_icon_path)
		icon = icon_texture
		
		
	
	
	

	#GlobalEventBus.emit_signal("debug_log",{
		#"msg":"Setting button payload: KeyName: {0} , KeyValue: {1}".format([key_payload.key_name,key_payload.key_value])
	#})
	
func _on_keyboard_input(payload: Dictionary) -> void:
	
	if key_payload.key_value.to_upper() == payload.key_value.to_upper():
		# send key to response container
		#$keyboard_key_tap_sound.playing  = true
		
		$keyboard_key_tap_sound.play()
		var ev_pressed := InputEventMouseButton.new()
		ev_pressed.button_index = MOUSE_BUTTON_LEFT
		ev_pressed.pressed = true
		ev_pressed.position = global_position
		Input.parse_input_event(ev_pressed)
		#var ev := InputEventMouseButton.new()
		ev_pressed.pressed = false
		Input.parse_input_event(ev_pressed)
		#grab_focus()
		#grab_click_focus()
		#button_pressed=true
		
		
	
func _ready() -> void:
	GlobalEventBus.connect("keyboard_input", _on_keyboard_input)
		
			
