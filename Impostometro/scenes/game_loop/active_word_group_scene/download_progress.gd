extends ProgressBar


func _on_show_audio_download_loader():
	visible=true

func _on_hide_audio_download_loader():
	visible=false

func _ready() -> void:
	GlobalEventBus.connect("show_audio_download_loader", _on_show_audio_download_loader)
	GlobalEventBus.connect("hide_audio_download_loader", _on_hide_audio_download_loader)
