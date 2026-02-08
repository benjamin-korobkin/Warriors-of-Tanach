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
	# In debug mode, use simple leftmost card for testing
	if board.debug_mode:
		set_current_card(hand.get_leftmost_card())
	else:
		# AI: choose strategically
		set_current_card(choose_best_card())
	put_in_field(get_current_card())



func put_in_field(card):
	card.move_to(board, -1, field.find_available_slot())
	card.set_is_faceup(false)
	yield(card._tween, "tween_all_completed")
	card.set_in_p2_field(true)
	finish_turn()


# AI Strategy Methods

func choose_best_card() -> Card:
	var hand_cards = hand.get_all_cards()
	var field_cards = field.get_occupying_cards()
	var opponent_cards = opponent.field.get_occupying_cards()
	
	var best_card = hand_cards[0]
	var best_score = score_card(best_card, field_cards, opponent_cards)
	
	for card in hand_cards:
		var card_score = score_card(card, field_cards, opponent_cards)
		if card_score > best_score:
			best_score = card_score
			best_card = card
	
	# Avoid playing a 0-power card that gains 0 points if we have better options
	if best_score == 0 and best_card.get_property("BasePower") == 0:
		# Find any card with positive score
		for card in hand_cards:
			var card_score = score_card(card, field_cards, opponent_cards)
			if card_score > 0:
				return card
	
	return best_card


func score_card(card: Card, field_cards: Array, opponent_cards: Array) -> int:
	var score = card.get_property("BasePower")
	
	# Bonus for card type synergy
	score += score_type_synergy(card, field_cards, opponent_cards)
	
	# Bonus for neighbor effects (previous card matters for this card's bonus)
	score += score_neighbor_effects(card, field_cards)
	
	# Bonus for enabling opponent-countering
	score += score_opponent_counters(card, opponent_cards)
	
	return score


func score_type_synergy(card: Card, field_cards: Array, opponent_cards: Array) -> int:
	var bonus = 0
	
	if is_shofet(card):
		# Shoftim stack: each existing shofet adds value
		var shofet_count = count_shoftim(field_cards)
		if card.card_id == CardID.ID.SHOFET_SHIMSHON:
			# Shimshon counts ALL shoftim on board
			bonus += (count_shoftim(field_cards) + count_shoftim(opponent_cards)) * 2
		else:
			# Regular shofet bonus per stack
			bonus += shofet_count * 3
	
	elif is_king(card):
		# Kings are strong baseline but need neighbors; modest bonus
		bonus += 2
	
	elif is_general(card):
		# Check for specific general synergies
		match card.card_id:
			CardID.ID.GENERAL_ELAZAR:
				# Worth more if it's the only general
				var general_count = count_generals(field_cards)
				if general_count == 0:
					bonus += 5
			CardID.ID.GENERAL_AVNER:
				# Worth more if we have advantage
				if count_generals(field_cards) > count_generals(opponent_cards):
					bonus += 4
			CardID.ID.GENERAL_BARAK:
				# High value if we can follow a shofet
				if count_shoftim(field_cards) > 0:
					bonus += 3
	
	return bonus


func score_neighbor_effects(card: Card, field_cards: Array) -> int:
	var bonus = 0
	
	# If there's a previous card, check bonuses this card gives to it
	if field_cards.size() > 0:
		var prev_card = field_cards[-1]  # Last played card
		
		if is_king(prev_card):
			# This card enables a king's next-card bonus
			match prev_card.card_id:
				CardID.ID.KING_DAVID:
					if is_general(card):
						bonus += 2
				CardID.ID.KING_SHAUL:
					if is_shofet(card):
						bonus += 2
				CardID.ID.KING_ASA:
					if is_general(card):
						bonus += 3
				CardID.ID.KING_CHIZKIYAHU:
					if is_shofet(card):
						bonus += 2
				CardID.ID.KING_YEHOSHAFAT:
					if is_general(card):
						bonus += 2
	
	return bonus


func score_opponent_counters(card: Card, opponent_cards: Array) -> int:
	var bonus = 0
	
	# Bonus for cards that counter opponent's setup
	match card.card_id:
		CardID.ID.GENERAL_YOAV:
			# +3 if opponent played king
			if opponent.is_king(opponent.get_current_card()):
				bonus += 3
		CardID.ID.GENERAL_ITTAI:
			# +3 if opponent played king
			if opponent.is_king(opponent.get_current_card()):
				bonus += 3
		CardID.ID.GENERAL_YONATAN:
			# Good against shoftim
			if count_shoftim(opponent_cards) > 0:
				bonus += 2
		CardID.ID.SHOFET_SHAMGAR:
			# +2 if opponent plays king
			if opponent.is_king(opponent.get_current_card()):
				bonus += 2
	
	return bonus
