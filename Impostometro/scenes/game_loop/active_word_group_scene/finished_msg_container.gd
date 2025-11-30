extends PanelContainer


@export var acerto_label: PackedScene

func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	


func _on_show_group_finished_msg(payload: Dictionary) -> void:	
	$VBoxContainer/total_words_container/total_words_value.text = str(payload.total_words_in_this_group)	
	$VBoxContainer/total_acertos_container/total_acertos_value.text = str(payload.total_acertos)
	var word_list_container = get_node("VBoxContainer/word_list_scroller/word_list_container")
	var words_in_this_group = payload.words_in_this_group
	var lista_de_acertos = payload.acertos
	
	var spacer_top = MarginContainer.new()
	#spacer_top.size_flags_vertical = Control.SIZE_EXPAND_FILL
	spacer_top.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	spacer_top.add_theme_constant_override("margin_top", 50)
	spacer_top.add_theme_constant_override("margin_bottom", 50)
	word_list_container.add_child(spacer_top)
	
	if lista_de_acertos.size() >0:
		var new_label = acerto_label.instantiate()
		new_label.text="Acertos:".to_upper()
		new_label.add_theme_color_override("font_color", Color.WHITE)
		word_list_container.add_child(new_label)
		
		
	for word in words_in_this_group:
		if word.word_to_listen.to_upper() in lista_de_acertos:
			var new_label_entry = acerto_label.instantiate()					
			new_label_entry.text=word.word_to_listen	
			new_label_entry.add_theme_color_override("font_color", Color.WHITE)			
			word_list_container.add_child(new_label_entry)
	
	word_list_container.add_child(spacer_top)
	if lista_de_acertos.size() < words_in_this_group.size():
		var new_erro_label = acerto_label.instantiate()
		new_erro_label.text="Erros:".to_upper()
		new_erro_label.add_theme_color_override("font_color", Color.WHITE)
		word_list_container.add_child(new_erro_label)
		word_list_container.add_child(spacer_top)
		
		for word in words_in_this_group:
			if word.word_to_listen.to_upper() not in lista_de_acertos:
				var new_label_entry = acerto_label.instantiate()		
				new_label_entry.add_theme_color_override("font_color", Color.WHITE)
				new_label_entry.text=word.word_to_listen	
				word_list_container.add_child(new_label_entry)

	word_list_container.add_child(spacer_top)
	
	visible=true
	#$finished_audio_player.play()
	#await get_tree().create_timer(1.5).timeout
	#visible=false
	
	#GlobalEventBus.emit_signal("load_next_word",{})



func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Finished MSG container"
	})
	visible=false
	GlobalEventBus.connect("show_group_finished_msg",_on_show_group_finished_msg)
