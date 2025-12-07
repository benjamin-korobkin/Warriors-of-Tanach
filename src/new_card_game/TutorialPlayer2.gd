extends Player

var ready_for_next_action : bool = true

export var test_mode : bool = false

signal replacing_p1_card(card)

func _ready() -> void:
	hand = board.get_node("Hand2")
	field = board.get_node("FieldContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()

func action_complete():
	ready_for_next_action = true
	
func play_turn():
	pass
		
func action():
	pass

func put_in_field(card):
	pass
