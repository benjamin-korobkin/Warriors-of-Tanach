extends Player


func _ready() -> void:
	._ready()
	hand = board.get_node("Hand2") as Area2D
	field = board.get_node("FieldContainer/FieldHBox2/FieldGrid2") as BoardPlacementGrid
	opponent = get_parent().get_node("Player1") as Node2D
	player_name = get_name() as String

	
func play_turn():
	.play_turn()  # set_has_moved(false)
	yield(get_tree().create_timer(1.0), "timeout")
	action()


func action():
	# Put in random card from hand
	set_current_card(hand.get_leftmost_card())
	put_in_field(get_current_card())



func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	yield(card._tween, "tween_all_completed")
	card.set_in_p2_field(true)
	finish_turn()
