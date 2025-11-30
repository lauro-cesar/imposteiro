extends Node
# Why use signals?
#Observer pattern (one to Many) or event bus pattern
# in terms of S.O.L.I.D, adheres to:
# D-> Depedendency Inversion Principle (decouples modules via abstraction)
# O-> Open/Closed Principle (can extend a Node or override behavior)


var VERSION_NUMBER = "0.0.1"
var REMOTE_VERSION ="0.0.2"
var LOCAL_VERSION = "0.0.1"

func needs_reload() -> bool:
	return LOCAL_VERSION != REMOTE_VERSION



signal debug_log(payload: Dictionary)
signal error_log(payload: Dictionary)
signal enable_indeterminate()
signal play_success_msg_audio
signal play_fail_msg_audio
signal play_results_msg_audio
signal show_audio_download_loader
signal hide_audio_download_loader
signal reset_cache_and_reload

signal after_show_success_msg(payload: Dictionary)
signal after_show_fail_msg(payload: Dictionary)

signal show_success_msg(payload: Dictionary)
signal show_fail_msg(payload: Dictionary)
signal update_latest_input_value_label(payload: Dictionary)
signal show_group_finished_msg(payload: Dictionary)

signal process_word_groups_collection(payload: Dictionary)
signal append_new_group_for_selection(payload: Dictionary)


signal set_play_next_word_button_visibility(payload: Dictionary)
signal check_for_build_version(payload: Dictionary)
signal show_keyboard(payload: Dictionary)
signal hide_keyboard(payload: Dictionary)
signal update_total_acertos_label(payload: Dictionary)
signal update_total_words_label(payload: Dictionary)
signal update_active_index_word_label(payload: Dictionary)
signal emit_label_updates(payload: Dictionary)
signal enter_fullscreen(payload: Dictionary)
signal exit_fullscreen(payload: Dictionary)

signal load_lobby(payload: Dictionary)
signal load_game_loop(payload: Dictionary)

#Game loop related
	
	
			
signal delete_last_key(payload: Dictionary)
signal delete_all(payload: Dictionary)
signal append_key(payload: Dictionary)
signal play_active_word(payload: Dictionary)
signal load_next_word(payload: Dictionary)
signal dismiss_open_word_group(payload: Dictionary)
			


signal append_space(payload: Dictionary)

signal latest_keyboard_input_value(payload: Dictionary)


signal keyboard_input(payload: Dictionary)


signal set_contdown_value(payload: Dictionary)

signal close_countdown(payload: Dictionary)
		
signal hide_main_loader(payload: Dictionary)
signal show_main_loader(payload: Dictionary)
signal open_word_group(payload: Dictionary)

signal open_groups_collection_file(payload: Dictionary)

signal download_groups_collection(payload: Dictionary)

signal conferir_resposta(payload: Dictionary)

signal play_letter(payload: Dictionary)
signal reset_letters(payload: Dictionary)
signal play_loaded_challenge_audio(payload: Dictionary)
signal play_selected_letter_audio(payload:Dictionary)
signal load_next_challenge(payload: Dictionary)
signal append_to_options_box(payload: Dictionary)
signal append_to_selection_box(payload: Dictionary)
signal select_letter(payload: Dictionary)
signal play_click_audio_effect(payload: Dictionary)
signal play_wav_from_path(payload: Dictionary)
signal play_audio

func _on_debug_log(payload: Dictionary) -> void:
	pass
	#print(payload.msg)
	
func get_local_version_number_from_path(payload: Dictionary) -> String:
	var latest_version = "0.0.1"
	var file := FileAccess.open(payload.file_path, FileAccess.READ)
	if file:
		var text := file.get_as_text()		
		file.close()
		var json = JSON.parse_string(text)
		latest_version = json.get('version_number')
	return latest_version
	
func set_version_number():
	var http := HTTPRequest.new()
	
	var local_version_file_path = "user://local_version_file.json"
	var remote_version_file_path = "user://remote_version_file.json"
	
	LOCAL_VERSION = get_local_version_number_from_path({
		"file_path":local_version_file_path
	})
	
	add_child(http)
	http.download_file = local_version_file_path
	var url = "https://lauro-cesar.github.io/imposteiro/assets/version.json"
	var err := http.request(url)
	if err != OK:
		print("Not ok")
	else:
		var result = await http.request_completed		
		var req_err: int = result[0]
		var code: int = result[1]
		#var headers: Dictionary = result[2]
		#var body: String = result[3]
		if req_err == OK and code == 200:
			pass			
	http.queue_free()
	REMOTE_VERSION = get_local_version_number_from_path({
		"file_path":local_version_file_path
	})
	VERSION_NUMBER = REMOTE_VERSION

	if needs_reload():
		emit_signal("reset_cache_and_reload") 
	else:
		emit_signal("download_groups_collection",{})
	
	
func _ready() -> void:
	GlobalEventBus.connect("debug_log",_on_debug_log)
	GlobalEventBus.emit_signal("debug_log",{"msg":"Global Event BUS ready"})	
	
	
