extends Player

var ready_for_next_action : bool = true

export var test_mode : bool = false

signal replacing_p1_card(card)

func _ready() -> void:
	hand = board.get_node("Hand2")
	timeline = board.get_node("FieldTimelineContainer/TimelineGrid")
	field = board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	opponent = get_parent().get_node("Player1")
	player_name = get_name()

func action_complete():
	ready_for_next_action = true
	
func play_turn():
	.play_turn()
	yield(get_tree().create_timer(1.0), "timeout")
	while not turn_over:
		if opponent.actions_remaining <= 0 and ready_for_next_action:
			action()
		yield(get_tree().create_timer(2.0), "timeout")
	for card in hand.get_all_cards():
		card.set_is_faceup(false)
		
func action():  ## Optimize. create method(s) for getting card type
	ready_for_next_action = false
	if hand.get_card_count() == 0:
		draw_card()
		return
	var current_hand = hand.get_all_cards()
	
	if can_put_in_timeline():
		# Start by replacing cards if possible
		for card in field.get_occupying_cards():
			if card.can_go_in_timeline(self):
				board.torah_challenge_panel.set_visible(true)
				emit_signal("replacing_p1_card", card)
				while board.torah_challenge_panel.is_visible():
					yield(get_tree(), "idle_frame")
				put_in_timeline(card)
				return
		# Don't put in a card if it means you'll likely lose
		if opponent.cards_in_timeline <= 2: 
			for card in current_hand:
				if card.get_name() == "Eliyahu HaNavi" and can_do_effect(card.get_name()):
					card.play_card(self)
					return
				if card.get_property("Type") == "Sage":
					if card.can_go_in_timeline(self): 
						put_in_timeline(card)
						return
			draw_card()
			return
		else: # If we reach this point, it means we need to focus on replacing p1 cards.
			# Grab P1 cards in timeline and calculate which card from hand to put in BM
			if field.count_available_slots() > 0:
				# Establish the eras of P1 cards in the timeline
				var temp_eras = []
				for card in timeline.get_occupying_cards():
					if card.get_card_owner() == "p1":
						temp_eras.append(card.get_property("Era"))
				for card in hand.get_occupying_cards():
					if card.get_property("Era") in temp_eras:
						put_in_field(card)
						return
			# Challenge using card in BM, this will aid in getting a relevant card in BM later
			# If full BD and no card can replace p1, we need to make space for one that can
			elif _challenge(field):
				return
			
	else:
		var tanach_card = null
		if field.count_available_slots() > 0:
			for card in current_hand:
				if card.get_property("Type") == "Sage":
					put_in_field(card)
					return
				elif card.get_property("Type") == "Tanach":
					if can_do_effect(card.get_name()):
						tanach_card = card
			if tanach_card:
				tanach_card.play_card(self)
				if tanach_card.get_property("Name") == "Elisha HaNavi":
					for card in hand.get_all_cards():
						card.set_is_faceup(false)
				return
		else: ## If we reach this code, it means the BM is full
			for card in current_hand:  ## Play Tanach card if we have
				if card.get_property("Type") == "Tanach":
					if can_do_effect(card.get_name()):
						card.play_card(self)
						return
			if _challenge(hand):
				return
	# If no other options can be performed, draw a card
	draw_card()

# If p1 has cards in BM, challenge them and return true. Otherwise false.
func _challenge(card_source : Node):
	var p1_field_cards = opponent.get_field().get_occupying_cards()
	if not p1_field_cards.empty(): ## Challenge
		var card_to_chlng = p1_field_cards[randi() % p1_field_cards.size()]
		## TODO: BUG when p2 challenges from its field ??
		var cards
		if card_source is Hand: ## TODO: Is this legal??
			cards = card_source.get_all_cards()
		else: # BoardPlacementGrid
			cards = card_source.get_occupying_cards()
		for card in cards:  
			if card.get_property("Type") == "Sage":
				current_card = card
				challenge(card_to_chlng)
				return true
	return false
	
func put_in_timeline(card):
	var era = card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	## TODO: Return false if opponent's own card
	
	if moshe_effect_enabled:
		moshe_effect_enabled = false
	else:
		spend_merits()
		deduct_action()
	if slot.occupying_card:
		slot.occupying_card.move_to(cfc.NMAP.discard)
		yield(slot.occupying_card._tween, "tween_all_completed")
		opponent.cards_in_timeline -= 1
	card.move_to(board, -1, slot)
	card.set_is_faceup(true)
	yield(card._tween, "tween_all_completed")
	card.global_position.y #+= 7  # Temp solution
	cards_in_timeline += 1
	update_counter(actions_str, actions_remaining)
	check_turn_over()
	action_completed()
	

func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	yield(card._tween, "tween_all_completed")
	card.global_position.y  # += 10  # Temp solution
	card.set_in_p2_field(true)
	deduct_action()
	update_counter(actions_str, actions_remaining)
	check_turn_over()
	action_completed()

func _on_Player2_action_completed() -> void:
	action_completed()
	
func action_completed():
	ready_for_next_action = true
