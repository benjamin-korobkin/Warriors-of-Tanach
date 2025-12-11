extends Player


func _ready() -> void:
	hand = board.get_node("Hand2")
	field = board.get_node("FieldContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()

	
func play_turn():
	.play_turn()  # set_has_moved(false)
	yield(get_tree().create_timer(1.0), "timeout")
	action()
#	for card in hand.get_all_cards():
#		card.set_is_faceup(false)
		
func action():  ## Optimize. create method(s) for getting card type
	var current_hand = hand.get_all_cards()
	# Put in random card from hand
	put_in_field(hand.get_rightmost_card())



func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	yield(card._tween, "tween_all_completed")
	card.set_in_p2_field(true)
#	update_counter()
	finish_turn()
