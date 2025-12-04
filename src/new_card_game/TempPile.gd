extends Pile


func _ready() -> void:
	pass

func add_child(node, _legible_unique_name=false) -> void:
	.add_child(node)
	$Control.self_modulate.a = 0.0

func remove_child(node, _legible_unique_name=false) -> void:
	.remove_child(node)
	$Control.self_modulate.a = 0.0
