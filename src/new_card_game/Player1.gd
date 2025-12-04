extends Player

onready var actions_menu = board.get_node("ActionsMenu")

func _ready() -> void:
	hand = board.get_node("Hand1")
	field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
	opponent = get_parent().get_node("Player2")
	player_name = get_name()

func add_points(amt):
	.add_points(amt)
