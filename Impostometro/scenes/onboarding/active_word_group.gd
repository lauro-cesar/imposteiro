extends MarginContainer

@export var button_play_audio_data: PackedScene 
#= preload("res://scenes/game_loop/word_groups/button_play_audio_data.tscn")


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	
	GlobalEventBus.add_user_signal("open_word_group", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])
	GlobalEventBus.add_user_signal("dismiss_open_word_group", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])


func _on_open_word_group(payload: Dictionary) -> void:
	visible=false
	var group_name = payload.get('group_name')
	var lista_de_palavras = payload.get('words_in_this_group', [])
	var grid_container = get_node("palavras_abertas")
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		child.free()
	
	for w in lista_de_palavras:	
		var new_card = button_play_audio_data.instantiate()
		new_card.custom_minimum_size = Vector2(200, 100)
		new_card.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		new_card.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		new_card.payload =  w
		new_card.text = w.word_to_listen				
		grid_container.add_child(new_card)			
	visible=true
	#$help_text_container.visible=true

		#print(w.word_to_listen)	
	#print("Abrir grupo de palavasr")
	
func _on_dismiss_open_word_group(payload: Dictionary) -> void:
	visible=false

func _ready() -> void:		
	_on_register_global_signals({
		"msg":"Registrando Active Word group"
	})
	GlobalEventBus.connect("open_word_group",_on_open_word_group)	
	GlobalEventBus.connect("dismiss_open_word_group",_on_dismiss_open_word_group)	
	
