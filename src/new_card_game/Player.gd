class_name Player
extends Node2D

signal points_updated(player, points)
signal action_completed

const ONLY_GENERAL_BONUS = 3

onready var board = get_parent().get_parent()
 
var current_card : Card setget set_current_card, get_current_card
var hand : Area2D
var field : BoardPlacementGrid
# var field_cards : Array
# var opponent_cards : Array
var card_type : String
var opponent : Node2D
var has_moved : bool setget set_has_moved, get_has_moved
var total_points : int = 0 setget set_total_points, get_total_points
var player_name : String


func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")

func play_turn():
	set_has_moved(false)
	
func finish_turn():
	set_has_moved(true)
	yield(get_tree().create_timer(0.7), "timeout")
	# Don't draw on the final round - game ends immediately after
	if get_parent().current_round < get_parent().TOTAL_ROUNDS:
		get_hand().draw_card()
	get_parent().turn_over()
	
func draw_card():
	hand.draw_card()
	

func reveal_card():
	var cc = get_current_card()
	cc.set_is_faceup(true)
	cc.set_card_rotation(0)
	# Mark which round this card was played
	cc.played_round = get_parent().current_round
	implement_condition()


func update_points():
	var tp : int = 0
	for card in field.get_occupying_cards():
		tp += card.get_property("Power")
	set_total_points(tp)
	emit_signal("points_updated", self, tp)
	
func recalc_power(card):
	var power = card.get_property("BasePower")
	for v in card.modifiers.values():
		power += v
	
	# Apply max_power cap if set
	if card.max_power != 0:
		power = min(card.max_power, power)

	card.modify_property("Power", power)



func implement_condition() -> void:
	var cc = get_current_card()
	var field_cards = field.get_occupying_cards()
	var opponent_cards = opponent.field.get_occupying_cards()

	apply_aura_effects(cc, field_cards, opponent_cards)
	apply_self_effects(cc, field_cards, opponent_cards)
	apply_shofet_effects(cc, field_cards)

	for card in field_cards:
		recalc_power(card)
	for card in opponent_cards:
		recalc_power(card)
	
func apply_aura_effects(cc, field_cards, opponent_cards) -> void:
	
	if is_general(cc):
		for card in field_cards:
			match card.card_id:
				## If Elazar plus another general is in the field, remove Elazar bonus
				CardID.ID.GENERAL_ELAZAR:
					if is_only_general_on_field(card, field_cards):
						set_modifier(card, "Elazar_bonus", ONLY_GENERAL_BONUS)
					else:
						set_modifier(card, "Elazar_bonus", 0)
				CardID.ID.GENERAL_AVNER:
					if count_generals(field_cards) > count_generals(opponent_cards):
						set_modifier(card, "avner_bonus", 2)
		for card in opponent_cards:
			# Only affect faceup cards. Otherwise, effects get stacked.
			if card.get_is_faceup():
				match card.card_id:
					CardID.ID.GENERAL_AVNER:
						if count_generals(field_cards) >= count_generals(opponent_cards):
							set_modifier(card, "avner_bonus", 0)
	

func apply_self_effects(cc, field_cards, opponent_cards) -> void:
	var card_id = cc.card_id
	if card_id == 0:
		push_error("CardID not set for card: " + cc.name)
		return
	var opp_card = opponent.get_current_card()
	var prev_card = get_prev_played_card()

	# Check if current card should give bonus to previous King
	if prev_card != null and is_king(prev_card):
		match prev_card.card_id:
			CardID.ID.KING_DAVID:
				# David: If next card is a General, +2
				if is_general(cc):
					add_modifier(prev_card, "king_bonus", 2)
			CardID.ID.KING_SHAUL:
				# Shaul: If next card is a Shofet, +2
				if is_shofet(cc):
					add_modifier(prev_card, "king_bonus", 2)
			CardID.ID.KING_ASA:
				# Asa: If next card is a General, +3
				if is_general(cc):
					set_modifier(prev_card, "king_bonus", 3)
			CardID.ID.KING_CHIZKIYAHU:
				# Chizkiyahu: If next card is a Shofet, +2
				if is_shofet(cc):
					add_modifier(prev_card, "king_bonus", 2)
			CardID.ID.KING_YEHOSHAFAT:
				# Yehoshafat: If next card is a General, +2
				if is_general(cc):
					add_modifier(prev_card, "king_bonus", 2)

	match card_id:
		CardID.ID.KING_DAVID:
			# If previous card is a General, +1. If next card is a General, +2
			if prev_card != null and is_general(prev_card):
				add_modifier(cc, "king_bonus", 1)
		CardID.ID.KING_SHAUL:
			# If previous card is General, +1. If next card is a Shofet, +3
			if prev_card != null and is_general(prev_card):
				add_modifier(cc, "king_bonus", 1)

		CardID.ID.KING_CHIZKIYAHU:
			# If previous card is a Shofet, +1. If next card is a Shofet, +2
			if prev_card != null and is_shofet(prev_card):
				add_modifier(cc, "king_bonus", 1)
		CardID.ID.KING_YEHOSHAFAT:
			# If previous card is a Shofet +1. If next card is a General, +2
			if prev_card != null and is_shofet(prev_card):
				add_modifier(cc, "king_bonus", 1)
		CardID.ID.GENERAL_YOAV:
			if is_king(opp_card):
				set_modifier(cc, "Yoav_bonus", 3)
		CardID.ID.GENERAL_BARAK:
			if prev_card != null and is_shofet(prev_card):
				if prev_card.card_id == CardID.ID.SHOFET_DEVORAH:
					add_modifier(cc, "Barak_bonus", 3)
				else:
					add_modifier(cc, "Barak_bonus", 2)
		CardID.ID.GENERAL_ELAZAR:
			if is_only_general_on_field(cc, field_cards):
				set_modifier(cc, "Elazar_bonus", ONLY_GENERAL_BONUS)
			else:
				set_modifier(cc, "Elazar_bonus", 0)
		CardID.ID.GENERAL_BENAIAH:
			if is_general(opp_card):
				add_modifier(cc, "Benaiah_bonus", 2)
		CardID.ID.GENERAL_YONATAN:
			if is_shofet(opp_card):
				add_modifier(cc, "Yonatan_bonus", 3)
		CardID.ID.GENERAL_ITTAI:
			if is_king(opp_card):
				set_modifier(cc, "Ittai_bonus", 3)
		CardID.ID.GENERAL_AMASA:
			# If opponent has 3 or more Shoftim, all Shoftim receive -1 Power
			var opp_shofet_count = count_shoftim(opponent_cards)
			if opp_shofet_count >= 3:
				apply_amasa_debuff(field_cards, opponent_cards)
		CardID.ID.GENERAL_AVNER:
			# +2 if you have more Generals than your opponent
			var my_general_count = count_generals(field_cards)
			var opp_general_count = count_generals(opponent_cards)
			if my_general_count > opp_general_count:
				set_modifier(cc, "avner_bonus", 2)
		CardID.ID.SHOFET_TOLEH:
			if is_shofet(opp_card):
				add_modifier(cc, "toleh_bonus", 2)
		CardID.ID.SHOFET_SHAMGAR:
			if is_king(opp_card):
				add_modifier(cc, "shamgar_bonus", 2)
		_:
			pass
	
func apply_shofet_effects(cc, field_cards) -> void:
	if is_shofet(cc):
		var bonus = shofet_bonus()
		var opponent_cards = opponent.field.get_occupying_cards()
		for card in field_cards:
			if is_shofet(card):
				if cc.card_id == CardID.ID.SHOFET_OSNIEL and card != cc:
					add_modifier(card, "osniel_bonus", 2)
				# Shimshon counts ALL Shoftim on board (both fields)
				if card.card_id == CardID.ID.SHOFET_SHIMSHON:
					var shimshon_bonus = count_shoftim(field_cards) + count_shoftim(opponent_cards) - 1
					set_modifier(card, "shofet_bonus", shimshon_bonus)
				else:
					set_modifier(card, "shofet_bonus", bonus)
	
func get_prev_played_card() -> Card:
	return field.get_previous_card(current_card)

func add_modifier(card, key: String, value: int) -> void:
	card.modifiers[key] = card.modifiers.get(key, 0) + value

func set_modifier(card, key, value):
	if value == 0:
		card.modifiers.erase(key)
	else:
		card.modifiers[key] = value

func cap_power(card, max_power_value: int) -> void:
	card.max_power = max_power_value

func is_only_general_on_field(target, field_cards) -> bool:
	for c in field_cards:
		if c != target and is_general(c):
			# Exception: Elchanan doesn't count for Elazar's ability
			if target.card_id == CardID.ID.GENERAL_ELAZAR and c.card_id == CardID.ID.GENERAL_ELCHANAN:
				continue
			return false
	return true


func is_general(card) -> bool:
	return CardID.is_general(card.card_id)

func is_shofet(card) -> bool:
	return CardID.is_shofet(card.card_id)

func is_king(card) -> bool:
	return CardID.is_king(card.card_id)

func opp_has_king(opponent_cards: Array) -> bool:
	for card in opponent_cards:
		if is_king(card) and card.get_is_faceup():
			return true
	return false


func shofet_bonus() -> int:
	var bonus = -1
	for card in field.get_occupying_cards():
		if is_shofet(card):
			bonus += 1
	return bonus

func has_card_in_field(card_id: int, field_cards: Array) -> bool:
	for card in field_cards:
		if card.card_id == card_id:
			return true
	return false

func count_shoftim(cards: Array) -> int:
	var count = 0
	for card in cards:
		if is_shofet(card):
			count += 1
	return count

func count_generals(cards: Array) -> int:
	var count = 0
	for card in cards:
		if is_general(card):
			count += 1
	return count

func apply_amasa_debuff(field_cards: Array, opponent_cards: Array) -> void:
	# Apply -1 to all Shoftim on both sides of the field
	for card in field_cards:
		if is_shofet(card):
			set_modifier(card, "amasa_debuff", -1)
	for card in opponent_cards:
		if is_shofet(card):
			set_modifier(card, "amasa_debuff", -1)

func set_current_card(card):
	current_card = card

func get_current_card() -> Card:
	return current_card
	
func get_field():
	return field
	
func get_hand():
	return hand
	
func set_has_moved(moved : bool):
	has_moved = moved

func get_has_moved():
	return has_moved
	
func set_total_points(points):
	total_points = points

func get_total_points() -> int:
	return total_points
