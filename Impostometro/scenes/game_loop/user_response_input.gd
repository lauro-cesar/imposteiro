extends TextEdit


func _focus_ios_input():
	JavaScriptBridge.eval("""
		const input = document.getElementById('proxyInput');
		input.focus();
		setTimeout(() => window.scrollTo(0, 0), 100);  // Force scroll reset
	""")

func _on_text_changed():	
	GlobalEventBus.emit_signal("append_to_selection_box",text)
