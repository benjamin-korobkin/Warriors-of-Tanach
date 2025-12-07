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
	yield(get_tree().create_timer(1.0), "timeout")
	action()
	yield(get_tree().create_timer(1.0), "timeout")
	for card in hand.get_all_cards():
		card.set_is_faceup(false)
		
func action():  ## Optimize. create method(s) for getting card type

	var current_hand = hand.get_all_cards()
	# Put in random card from hand
	if field.count_available_slots() > 0:
		for card in hand.get_occupying_cards():
			put_in_field(card)
			finish_turn()
			return


func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	yield(card._tween, "tween_all_completed")
	card.set_in_p2_field(true)
#	update_counter()
	finish_turn()
