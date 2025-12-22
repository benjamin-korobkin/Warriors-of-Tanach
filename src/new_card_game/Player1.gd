extends Player


func _ready() -> void:
	._ready()
	hand = board.get_node("Hand1") as Area2D
	field = board.get_node("FieldContainer/FieldHBox1/FieldGrid1") as BoardPlacementGrid
	opponent = get_parent().get_node("Player2") as Node2D
	player_name = get_name() as String
