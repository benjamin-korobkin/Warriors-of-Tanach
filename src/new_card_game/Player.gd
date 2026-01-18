class_name Player
extends Node2D

signal points_updated(player, points)
signal action_completed

const ONLY_GENERAL_BONUS = 4

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
	## General to King Effect
	if is_general(cc):
		for card in field_cards:
			match card.card_id:
				CardID.ID.KING_DAVID:
					add_modifier(card, "king_bonus", 2)
				CardID.ID.KING_SHAUL:
					add_modifier(card, "king_bonus", 2)
				CardID.ID.KING_ASA:
					add_modifier(card, "king_bonus", 2)
				CardID.ID.KING_YEHOSHAFAT:
					add_modifier(card, "king_bonus", 3)
				## If Elazar plus another general is in the field, remove Elazar bonus
				CardID.ID.GENERAL_ELAZAR:
					if is_only_general_on_field(card, field_cards):
						set_modifier(card, "Elazar_bonus", ONLY_GENERAL_BONUS)
					else:
						set_modifier(card, "Elazar_bonus", 0)
		for card in opponent_cards:
			# Only affect faceup Kings. Otherwise, effects get stacked.
			if card.get_is_faceup():
				match card.card_id:
					CardID.ID.KING_DAVID:
						add_modifier(card, "king_bonus", -1)
					CardID.ID.KING_SHAUL:
						add_modifier(card, "king_bonus", -2)
					CardID.ID.KING_YEHOSHAFAT:
						add_modifier(card, "king_bonus", -3)
	
	## Shofet to King Effect
	if is_shofet(cc):
		for card in opponent_cards:
			# Only affect faceup Kings. Otherwise, effects get stacked.
			if card.get_is_faceup():
				match card.card_id:
					CardID.ID.KING_CHIZKIYAHU:
						add_modifier(card, "king_bonus", -2)
	
	## If opponent plays a King, apply Chizkiyahu's power cap
	if is_king(cc):
		for card in opponent_cards:
			if card.card_id == CardID.ID.KING_CHIZKIYAHU:
				cap_power(card, 5)

func apply_self_effects(cc, field_cards, opponent_cards) -> void:
	var card_id = cc.card_id
	if card_id == 0:
		push_error("CardID not set for card: " + cc.name)
		return
	var opp_card = opponent.get_current_card()
	var prev_card = get_prev_played_card()

	match card_id:
		CardID.ID.KING_DAVID:
			king_effect(field_cards, opponent_cards, 2, -1)
		CardID.ID.KING_SHAUL:
			king_effect(field_cards, opponent_cards, 2, -2)
		CardID.ID.KING_ASA:
			king_effect(field_cards, opponent_cards, 2, 0)
			# Power cap at 5 if opponent has a king
			if opp_has_king(opponent_cards):
				cap_power(cc, 5)
		CardID.ID.KING_CHIZKIYAHU:
			king_effect(field_cards, opponent_cards, 2, -1, "shofet")
		CardID.ID.KING_YEHOSHAFAT:
			king_effect(field_cards, opponent_cards, 3, -3)
		CardID.ID.GENERAL_YOAV:
			if is_king(opp_card):
				set_modifier(cc, "Yoav_bonus", 4)
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
				add_modifier(cc, "Benaiah_bonus", 3)
		CardID.ID.GENERAL_YONATAN:
			if is_shofet(opp_card):
				add_modifier(cc, "Yonatan_bonus", 3)
		CardID.ID.GENERAL_AVISHAI:
			if prev_card != null and is_general(prev_card):
				if prev_card.card_id == CardID.ID.GENERAL_YOAV:
					add_modifier(cc, "Avishai_bonus", 3)
				else:
					add_modifier(cc, "Avishai_bonus", 2)
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
				add_modifier(cc, "avner_bonus", 2)
		CardID.ID.SHOFET_TOLEH:
			if is_shofet(opp_card):
				add_modifier(cc, "toleh_bonus", 2)
		_:
			pass
	
func apply_shofet_effects(cc, field_cards) -> void:
	if is_shofet(cc):
		var bonus = shofet_bonus()
		for card in field_cards:
			if is_shofet(card):
				if cc.card_id == CardID.ID.SHOFET_OSNIEL and card != cc:
					add_modifier(card, "osniel_bonus", 2)
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


func king_effect(field_cards, opponent_cards, amt_add, amt_sub, card_type := "general"):
	var king_bonus : int = 0
	for card in field_cards:
		if card_type == "shofet" and is_shofet(card):
			king_bonus += amt_add
		elif card_type == "general" and is_general(card):
			king_bonus += amt_add
	for card in opponent_cards:
		if card_type == "shofet" and is_shofet(card) and card.get_is_faceup():
			king_bonus += amt_sub
		elif card_type == "general" and is_general(card) and card.get_is_faceup():
			king_bonus += amt_sub
	add_modifier(current_card, "king_bonus", king_bonus)

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
