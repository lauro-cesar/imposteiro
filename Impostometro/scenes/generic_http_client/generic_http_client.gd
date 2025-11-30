extends HTTPRequest

var request_queue = []
var active_payload: Dictionary = {}
var is_busy = false
var total_size := 0
var received_size := 0


func _on_register_global_signals(payload: Dictionary) -> void:
	pass
	#GlobalEventBus.add_user_signal("get_request", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])	

func _on_connect_global_signals():
	pass 

## Processa o response do request
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var results = json.get('results')
	var on_complete_event = active_payload.get('on_complete_event','none')
	var response = {
		"results":results
	}
	GlobalEventBus.emit_signal(on_complete_event,response)
	is_busy=false


func _physics_process(_delta: float) -> void:	
	if not is_busy:
		if not request_queue.is_empty():
			active_payload = request_queue.pop_front()
			var url = active_payload.get('url','')
			request(url)
			is_busy=true
			#GlobalEventBus.emit_signal("enable_indeterminate")
			
	if is_busy:
		var active_status = get_downloaded_bytes()
		#print(active_status)
		 
		

## Append um payload na fila
func _on_get_request(payload: Dictionary):
	request_queue.append(payload)

func _ready() -> void:
	_on_register_global_signals({
		"msg":"Registrando http client"
	})
	
	#request_completed.connect(_on_request_completed)
	#GlobalEventBus.connect("get_request",_on_get_request)
	
	
