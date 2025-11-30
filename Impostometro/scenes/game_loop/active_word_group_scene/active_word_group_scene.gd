extends Control


var window = JavaScriptBridge.get_interface("window")
var active_index: int = 0
var active_text: String = ""
var last_input_text:String = ""
var listen_for_keyboard: bool = false
var active_word: Dictionary = {}
var active_payload: Dictionary = {}
var words_in_this_group: Array = []
var last_input_list: PackedStringArray = []
@export var timeout:= 3.0
var acertos: Array = []

func can_load_next():
	if (active_index == words_in_this_group.size()):
		GlobalEventBus.emit_signal("show_group_finished_msg",{
			"active_payload":active_payload,
			"acertos":acertos,
			"words_in_this_group":words_in_this_group,
			"total_words_in_this_group":str(words_in_this_group.size()),
			"total_acertos":acertos.size()
		})
	else:
		GlobalEventBus.emit_signal("load_next_word",{})
		
			

func _on_after_show_fail_msg(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("delete_all",{})
	can_load_next()
	
	
func _on_after_show_success_msg(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("delete_all",{})
	can_load_next()
	

func _on_conferir_resposta(payload: Dictionary) -> void:
	var last_text = "".join(last_input_list)
	var last_text_upper = last_text.to_upper() 
	var active_word_upper = active_word.word_to_listen.to_upper()
	if (active_word_upper == last_text_upper):
		if active_word_upper not in acertos:
			acertos.append(active_word_upper)
		GlobalEventBus.emit_signal("update_total_acertos_label",{"value":str(acertos.size())})
		#GlobalEventBus.emit_signal("show_success_msg",{"value":str(acertos.size())})
		GlobalEventBus.emit_signal("play_success_msg_audio")
	else:
		GlobalEventBus.emit_signal("show_fail_msg",{
			"active_payload":active_payload,
			"show_results":(active_index == words_in_this_group.size()),
			"active_word_upper":active_word_upper,
			"last_text_upper":last_text_upper,
			"value":str(acertos.size())})

		GlobalEventBus.emit_signal("play_fail_msg_audio")
	

func _on_append_space(payload: Dictionary) -> void:
	last_input_list.append(" ")
	var last_text = "".join(last_input_list)
	GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":last_text})
	GlobalEventBus.emit_signal("debug_log",{"msg":"_SPACE_"})
	

func _on_delete_all(payload: Dictionary) -> void:
	last_input_list.clear()
	GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":""})
		
		
func _on_delete_last_key(payload: Dictionary) -> void:
	var last_index = last_input_list.size()-1
	var last_clamped = clamp(last_index,0,last_input_list.size()+1)
	if not last_input_list.is_empty():
		last_input_list.remove_at(last_clamped)
	var last_text = "".join(last_input_list)	
	GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":last_text})


func _on_append_key(payload: Dictionary) -> void:
	var character = str(payload.key_value)
	last_input_list.append(character)
	var last_text = "".join(last_input_list)
	GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":last_text})
	GlobalEventBus.emit_signal("debug_log",{"msg":character})

	

func _input(event: InputEvent) -> void:	
			#if Input.is_action_pressed("ui_text_submit"):
		#GlobalEventBus.emit_signal("load_next_word",{})
	#
	#if Input.is_action_pressed("ui_accept"):
		#GlobalEventBus.emit_signal("load_next_word",{})
		
	if Input.is_action_pressed("ui_text_delete"):
		GlobalEventBus.emit_signal("delete_all",{})
	
	if Input.is_action_pressed("ui_text_backspace"):
		GlobalEventBus.emit_signal("delete_last_key",{})

	#if event is InputEventKey and event.unicode != 0:		
		#var character := char(event.unicode)		
		#GlobalEventBus.emit_signal("append_key",{
			#"key_value":str(character)
		#})
		#
		#GlobalEventBus.emit_signal("keyboard_input",{
			#"key_value":character
		#})		



#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.unicode != 0 and event.pressed:
		#var character := char(event.unicode)
		#GlobalEventBus.emit_signal("debug_log",{"msg":character})
			
func _physics_process(delta: float) -> void:
	var last_text = "".join(last_input_list)
	if last_input_text.to_upper() != last_text.to_upper():
		last_input_text = last_text		
		GlobalEventBus.emit_signal("update_latest_input_value_label",{
			"value":last_input_text
		})
	
func _process(delta: float) -> void:
	pass 

		
		
	
	#print(last_text)
	
	
	##if OS.has_feature('web'):
		###only forward if input_text != active_text
		##var input_text = window.getKeyboardInput()
		##if active_text != input_text:
			##active_text=input_text			
			##GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":input_text})	
		##
	#if timeout > 0.1:
		#timeout -= delta
		#GlobalEventBus.emit_signal("set_contdown_value",{"value":timeout})	


func _on_dismiss_open_word_group(payload: Dictionary) -> void:
	visible=false
	queue_free()
		
func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	

func _on_emit_label_updates(input_payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("update_total_words_label",{"value":str(words_in_this_group.size())})
	GlobalEventBus.emit_signal("update_total_acertos_label",{"value":str(acertos.size())})
	GlobalEventBus.emit_signal("update_active_index_word_label",{"value":str(active_index)})

func load_payload(input_payload: Dictionary) -> void:
	# Copiar a lista de palavras s	
	active_payload = input_payload
	active_index =0
	words_in_this_group = active_payload.words_in_this_group
	
	GlobalEventBus.emit_signal("debug_log",{"msg":"Registrando Active Payload from words Size: {0}".format([words_in_this_group.size()])})	
	#GlobalEventBus.emit_signal("render_",{"msg":"Registrando Active Payload from words"})	
	GlobalEventBus.emit_signal("set_play_next_word_button_visibility",{"state":(words_in_this_group.size()>1)})
	#GlobalEventBus.emit_signal("update_total_words_label",{"value":words_in_this_group.size()})	
	GlobalEventBus.emit_signal("update_total_acertos_label",{"value":str(words_in_this_group.size())})
	
func _on_show_success_msg(payload: Dictionary) -> void:
	pass 
	
func _on_close_countdown(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("load_next_word",{})
	
func _on_play_results_msg_audio():	
	var audio_path_file = "user://{0}-results-msg.wav".format([GlobalEventBus.VERSION_NUMBER])	
	if FileAccess.file_exists(audio_path_file):
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
	else:
		GlobalEventBus.emit_signal("show_audio_download_loader")
		var http := HTTPRequest.new()
		add_child(http)
		http.download_file = audio_path_file
		var url = "https://lauro-cesar.github.io/imposteiro/static/completed2.wav"		
		var err := http.request(url)
		if err != OK:
			pass 
		else:
			var result = await http.request_completed
			var req_err: int = result[0]
			var code: int = result[1]
			if req_err == OK and code == 200:
				pass
		
		http.queue_free()
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
		
		
func _on_play_fail_msg_audio():
	var audio_path_file = "user://{0}-fail-msg.wav".format([GlobalEventBus.version_number])	
	if FileAccess.file_exists(audio_path_file):
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
	else:
		GlobalEventBus.emit_signal("show_audio_download_loader")
		var http := HTTPRequest.new()
		add_child(http)
		http.download_file = audio_path_file
		var url = "https://lauro-cesar.github.io/imposteiro/static/denied.wav"		
		var err := http.request(url)
		if err != OK:
			pass 
		else:
			var result = await http.request_completed
			var req_err: int = result[0]
			var code: int = result[1]
			if req_err == OK and code == 200:
				pass
		
		http.queue_free()
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
	
	GlobalEventBus.emit_signal("after_fail_success_msg",{})
		
func _on_play_success_msg_audio():
	var audio_path_file = "user://{0}-success-msg.wav".format([GlobalEventBus.VERSION_NUMBER])		
	if FileAccess.file_exists(audio_path_file):
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
	else:
		GlobalEventBus.emit_signal("show_audio_download_loader")
		var http := HTTPRequest.new()
		add_child(http)
		http.download_file = audio_path_file
		var url = "https://lauro-cesar.github.io/imposteiro/static/sequence.wav"		
		var err := http.request(url)
		if err != OK:
			pass 
		else:
			var result = await http.request_completed
			var req_err: int = result[0]
			var code: int = result[1]
			if req_err == OK and code == 200:
				pass
		
		http.queue_free()
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":audio_path_file})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
		
	GlobalEventBus.emit_signal("after_show_success_msg",{})
	

func _on_play_active_word(payload: Dictionary) -> void:	
	var active_word_audio_path  = "user://{0}.wav".format([active_word.audio_serial])
	if FileAccess.file_exists(active_word_audio_path):
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":active_word_audio_path})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
	else:
		GlobalEventBus.emit_signal("show_audio_download_loader")
		var http := HTTPRequest.new()
		add_child(http)
		http.download_file = active_word_audio_path
		var url = "https://lauro-cesar.github.io/imposteiro/{0}".format([active_word.audio_path])		
		var err := http.request(url)
		if err != OK:
			pass 
		else:
			var result = await http.request_completed
			var req_err: int = result[0]
			var code: int = result[1]
			if req_err == OK and code == 200:
				pass
		http.queue_free()
		GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":active_word_audio_path})
		GlobalEventBus.emit_signal("hide_audio_download_loader")
		
	#print(active_word.audio_path)
	#print(active_word.audio_serial)	
	#var base64_audio_data = active_word.get('audio_data',false)
	#var bytes: PackedByteArray = Marshalls.base64_to_raw(base64_audio_data)
	#GlobalEventBus.emit_signal("play_wav_from_bytes",{"bytes":bytes})	
	
func _on_request_download_audio_data_completed(result, response_code, headers, body):
	#var active_word_audio_path  = "user://{0}.wav".format([active_word.audio_serial])
	#GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":active_word_audio_path})
	
	GlobalEventBus.emit_signal("hide_audio_download_loader")
	
	
func _on_load_next_word(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("latest_keyboard_input_value",{"value":""})
	last_input_list.clear()
	if (active_index < words_in_this_group.size()):
		GlobalEventBus.emit_signal("set_play_next_word_button_visibility",{"state":true})
		active_word = words_in_this_group[active_index]
		active_index +=1
		GlobalEventBus.emit_signal("play_active_word",{})
		GlobalEventBus.emit_signal("emit_label_updates",{})
		


			
		
	
		
		#
		#active_index=0
		

func _on_keyboard_visibility_changed(visible: bool):
	pass

	
func _ready() -> void:	
	_on_register_global_signals({
		"msg":"Registrando Active Group"
	})
	GlobalEventBus.connect("dismiss_open_word_group", _on_dismiss_open_word_group)
	GlobalEventBus.connect("close_countdown",_on_close_countdown)
	GlobalEventBus.connect("load_next_word", _on_load_next_word)	
	GlobalEventBus.connect("play_active_word", _on_play_active_word)
	GlobalEventBus.connect("append_key", _on_append_key)
	GlobalEventBus.connect("delete_all", _on_delete_all)
	GlobalEventBus.connect("delete_last_key", _on_delete_last_key)
	GlobalEventBus.connect("conferir_resposta", _on_conferir_resposta)
	GlobalEventBus.connect("append_space", _on_append_space)
	GlobalEventBus.connect("emit_label_updates", _on_emit_label_updates)
	GlobalEventBus.connect("show_success_msg", _on_show_success_msg)
	GlobalEventBus.connect("after_show_success_msg", _on_after_show_success_msg)
	GlobalEventBus.connect("after_show_fail_msg", _on_after_show_fail_msg)
	GlobalEventBus.connect("play_results_msg_audio",_on_play_results_msg_audio)
	GlobalEventBus.connect("play_success_msg_audio",_on_play_success_msg_audio)
	GlobalEventBus.connect("play_fail_msg_audio",_on_play_fail_msg_audio)
	
	#$generic_http_client.request_completed.connect(_on_request_download_audio_data_completed)
	
	
	_on_load_next_word({})
	
	
	
	
		
func _enter_tree() -> void:
	timeout = 5.0
