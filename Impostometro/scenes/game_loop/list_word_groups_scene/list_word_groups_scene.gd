extends Control

var groups_collection_path = "user://groups_collection.json"
var groups_collection_data:Dictionary = {}
	
func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)

func _on_request_completed(result, response_code, headers, body):
	GlobalEventBus.emit_signal("debug_log",{"msg":"Running on_request_completed"})
			
	var file := FileAccess.open(groups_collection_path, FileAccess.WRITE)
	if file:		
		file.store_string(body.get_string_from_utf8())
		file.flush() 
		file.close()
		GlobalEventBus.emit_signal("open_groups_collection_file",{})
		GlobalEventBus.emit_signal("hide_main_loader",{})
	#
func _on_open_groups_collection_file(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",{"msg":"Running _on_open_groups_collection_file"})
	
	var file := FileAccess.open(groups_collection_path, FileAccess.READ)
	if file:
		GlobalEventBus.emit_signal("debug_log",{"msg":"Opening file path {0}".format([groups_collection_path])})
		var text := file.get_as_text()
		file.close()
		var json = JSON.parse_string(text)		
		var results = json.get('results')	
		var response = {
			"results":results
		}
		GlobalEventBus.emit_signal("process_word_groups_collection",response)
		GlobalEventBus.emit_signal("hide_main_loader",{})
	
func _on_download_groups_collection(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("show_main_loader",{})
	GlobalEventBus.emit_signal("debug_log",{"msg":"Running on_download_groups_collection"})
	$generic_http_client.request("https://lauro-cesar.github.io/imposteiro/group-of-words/")


func _on_check_for_build_version(payload: Dictionary) -> void:
	var build_version = payload.build_version
	


		
	
	
	#var version_number_file_path  = "user://{0}-{1}.wav".format([build_version,active_word.audio_serial])
	#if FileAccess.file_exists(active_word_audio_path):
		#GlobalEventBus.emit_signal("play_wav_from_path",{"file_path":active_word_audio_path})
		#GlobalEventBus.emit_signal("hide_audio_download_loader")
	#else:
		#GlobalEventBus.emit_signal("show_audio_download_loader")
		#var http := HTTPRequest.new()
		#add_child(http)
		#http.download_file = active_word_audio_path
		##var url = "https://lauro-cesar.github.io/imposteiro/{0}".format([active_word.audio_path])		
		#var err := http.request(url)
		#if err != OK:
			#pass 
		#else:
			#var result = await http.request_completed
			#var req_err: int = result[0]
			#var code: int = result[1]
			#if req_err == OK and code == 200:
				#print("Saved WAV to: ", active_word_audio_path)		
		#http.queue_free()
		
			

	
		 

func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando Word Groups listing"
	})
	$generic_http_client.request_completed.connect(_on_request_completed)
	GlobalEventBus.connect("open_groups_collection_file", _on_open_groups_collection_file)
	GlobalEventBus.connect("download_groups_collection",_on_download_groups_collection)		
	GlobalEventBus.connect("check_for_build_version",_on_check_for_build_version)
	GlobalEventBus.emit_signal("show_main_loader",{})
		
	
	#if FileAccess.file_exists(groups_collection_path):	
		#GlobalEventBus.emit_signal("debug_log",{"msg":"Sending signal open_groups_collection_file"})
		#GlobalEventBus.emit_signal("open_groups_collection_file",{})				
	#else:
		#GlobalEventBus.emit_signal("debug_log",{"msg":"Sending signal download_groups_collection"})
		#GlobalEventBus.emit_signal("download_groups_collection",{})		
			#
		

	
	

	
