extends Control


func _on_register_global_signals(payload: Dictionary) -> void:
	print("Register login pipeline signals")

func _ready() -> void:
	_on_register_global_signals({})


func _enter_tree() -> void:
	print("Login pipeline entered the tree")

func _exit_tree() -> void:
	print("Login pipeline Exited the tree")
