extends Node2D
@export var letter_scene: PackedScene = preload("res://scenes/letter/letter.tscn")
var number_of_instances := 25
var spawn_delay := 0.5

func start_instantiating() -> void:
	# use `await` for timing
	for i in number_of_instances:
		var instance = letter_scene.instantiate()
		add_child(instance)  # or add it somewhere else
		await get_tree().create_timer(spawn_delay).timeout
		
func _ready() -> void:
	start_instantiating()
