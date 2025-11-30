extends TextureRect

@export var url: String = ""
@export var timeout_sec: int = 30
@export var show_stretch: bool = true           ## auto set stretch modes for nice display

var _http: HTTPRequest
var _attempt: int = 0

func _ready() -> void:
	if show_stretch:
		expand_mode = TextureRect.EXPAND_FIT_WIDTH  # or EXPAND_IGNORE_SIZE if you prefer
		stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


	# Create and configure HTTPRequest at runtime (keeps node self-contained)
	#_http = HTTPRequest.new()
	#_http.timeout = timeout_sec
	#_http.accept_gzip = true
	#_http.use_threads = true
	#add_child(_http)
	#_http.request_completed.connect(_on_request_completed)

	#if auto_request and url != "":
		#load_url(url)


func load_url(new_url: String) -> void:
	url = new_url
	_attempt = 0
	_request_now()


func _request_now() -> void:
	_attempt += 1
	var err := _http.request(url)
	if err != OK:
		push_warning("RemoteImageRect: request() failed with code %s" % err)

func _parse_content_type(headers: PackedStringArray) -> String:
	for h in headers:
		# Example: "Content-Type: image/png; charset=utf-8"
		if h.to_lower().begins_with("content-type:"):
			var parts := h.split(":", true, 1)
			if parts.size() == 2:
				var ct := parts[1].strip_edges().split(";", true, 1)[0].strip_edges()
				return ct.to_lower()
	return ""
	

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:

	var mime := _parse_content_type(headers)
	var img := Image.new()
	var load_ok := ERR_FILE_UNRECOGNIZED
	load_ok = img.load_png_from_buffer(body)

	var tex := ImageTexture.create_from_image(img)
	texture = tex
