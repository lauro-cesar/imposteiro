#extends GridContainer
#extends ItemList
extends VBoxContainer

@export var margins_px: int = 8 
@export var card_open_group: PackedScene


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	


func _on_process_word_groups_collection(payload: Dictionary) -> void:
	for child in get_children():
		child.queue_free()
		
	var results = payload.get('results', [])
	for record in results:
		GlobalEventBus.emit_signal("append_new_group_for_selection",record)
	GlobalEventBus.emit_signal("hide_main_loader",{})

	
func _on_append_new_group_for_selection(payload: Dictionary) -> void:
	var group_name = payload.get('group_name')
	var new_card = card_open_group.instantiate()
	#var label_do_grupo = new_card.get_node("button_open_group/label_do_grupo")
	#label_do_grupo.text = group_name

	#str(payload.words_in_this_group.size())
	var button_open = new_card.get_node("button_container/button_open_group")
	button_open.payload =  payload	
	button_open.text = group_name
	add_child(new_card)
	

	#var image_data = payload.get('group_card_image_data')
	#var texture_rect = new_card.get_node("bg_image")
	#var img := Image.new()
	#var err = img.load_png_from_buffer(Marshalls.base64_to_raw(image_data))
	#if err == OK:
		#var tex = ImageTexture.create_from_image(img)
		#texture_rect.texture = tex

	

func _on_request_completed(result, response_code, headers, body):
	pass

func _ready() -> void:		
	_on_register_global_signals({
		"msg":"Registrando Grid de selecao"
	})
	GlobalEventBus.connect("process_word_groups_collection",_on_process_word_groups_collection)	
	GlobalEventBus.connect("append_new_group_for_selection",_on_append_new_group_for_selection)	
