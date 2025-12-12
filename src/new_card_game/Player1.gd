extends Player


func _ready() -> void:
	hand = board.get_node("Hand1")
	field = board.get_node("FieldContainer/FieldHBox1/FieldGrid1")
	opponent = get_parent().get_node("Player2")
	player_name = get_name()
