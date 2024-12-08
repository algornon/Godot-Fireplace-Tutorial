extends Node2D

@onready var fireplace: Node2D = $Fireplace

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		fireplace.toggle()
