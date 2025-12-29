class_name Player
extends Node2D

signal points_updated(player, points)
signal action_completed

const ONLY_GENERAL_BONUS = 5

onready var board = get_parent().get_parent()
 
var current_card : Card setget set_current_card, get_current_card
var hand : Area2D
var field : BoardPlacementGrid
var field_cards : Array
var opponent_cards : Array
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
	get_hand().draw_card()
	get_parent().turn_over()
	
func draw_card():
	hand.draw_card()
	

func reveal_card():
	var cc = get_current_card()
	cc.set_is_faceup(true)
	cc.set_card_rotation(0)
	implement_condition(cc)


func update_points():
	var total_points : int = 0
	for card in field.get_occupying_cards():
		total_points += card.get_property("Power")
	set_total_points(total_points)
	emit_signal("points_updated", self, total_points)
	
func calc_shofet_pow(card):
	var power = card.get_property("Base_Power")
	for value in card.shofet_modifiers.values():
		power += value
	
	card.modify_property("Power", power)


func implement_condition(current_card) -> void:
	field_cards = field.get_occupying_cards()
	opponent_cards = opponent.field.get_occupying_cards()
	card_type = current_card.get_property("Type")
	# power = current_card.get_property("Power")
	apply_general_auras(current_card)
	apply_named_card_effects(current_card)
	apply_shofet_effects(current_card)

	
func apply_general_auras(current_card) -> void:
	## General to King Effect
	if is_general(current_card):
		for card in field_cards:
			var name = card.get_property("Name")
			if "David" in name:
				add_pow(card, 2)
			elif "Shaul" in name:
				add_pow(card, 2)
			elif "Asa" in name:
				add_pow(card, 1)
			elif "Chizkiyahu" in name:
				add_pow(card, 3)
			elif "Elazar ben Dodo" in name and \
				card.get_property("Power") == 7:
				add_pow(card, -ONLY_GENERAL_BONUS)
		for card in opponent_cards:
			# Only affect faceup Kings. Otherwise, effects get stacked.
			if card.get_is_faceup():
				var name = card.get_property("Name")
				if "David" in name:
					add_pow(card, -2)
				elif "Shaul" in name:
					add_pow(card, -1)
				elif "Chizkiyahu" in name:
					add_pow(card, -3)


func apply_named_card_effects(current_card) -> void:
	var card_id = current_card.get_property("CardID")
	var opp_card = opponent.get_current_card()
	var prev_card = get_prev_played_card()

	match card_id:
		"David HaMelech":
			king_effect(2, -2)
		"Shaul HaMelech":
			king_effect(2, -1)
		"Asa HaMelech":
			king_effect(1, 0)
		"Chizkiyahu HaMelech":
			king_effect(3, -3)
		"Yoav":
			if "King" in opp_card.get_property("Type"):
				add_pow(current_card, 4)
		"Barak":
			if prev_card != null and "Shofet" in prev_card.get_property("Type"):
				if "Devorah" in prev_card.get_property("Name"):
					add_pow(current_card, 3)
				else:
					add_pow(current_card, 2)
		"Elazar ben Dodo":
			if is_only_general_on_field():
				add_pow(current_card, ONLY_GENERAL_BONUS)
		"Ittai":
			if prev_card != null and "General" in prev_card.get_property("Type"):
				add_pow(current_card, 2)
		"Benaiah":
			if "General" in opp_card.get_property("Type"):
				add_pow(current_card, 3)
		"Toleh ben Puah":
			if "Shofet" in opp_card.get_property("Type"):
				current_card.shofet_modifiers["toleh_bonus"] += 2
		_:
			pass
	
func apply_shofet_effects(current_card) -> void:
	if "Shofet" in card_type:
		var bonus = shofet_bonus()
		for card in field_cards:
			if "Shofet" in card.get_property("Type"):
				if card_name == "Osniel ben Kenaz" and not_same_card(card, current_card):
					card.shofet_modifiers["osniel_bonus"] += 2
				card.shofet_modifiers["shofet_bonus"] = bonus
				calc_shofet_pow(card)



func get_prev_played_card() -> Card:
	return field.get_previous_card(current_card)

func add_pow(card, add_power):
	# var power_str = ("+" if power >= 0 else "") + str(power)
	var p = card.get_property("Power")
	var power = p + add_power
	card.modify_property("Power", power)

func king_effect(amt_add, amt_sub):
	var bonus : int = 0
	var cc = current_card
	var n = cc.get_property("Name")
	for card in field.get_occupying_cards():
		if is_general(card):
			bonus += amt_add
			# add_pow(current_card, amt_add)
			#print(amt_add, " points added to ", n)
	for card in opponent.field.get_occupying_cards():
		if is_general(card) and card.get_is_faceup():
			bonus += amt_sub
			# add_pow(current_card, amt_sub)
#			print(amt_sub, " points from ", n)
	add_pow(cc, bonus)

func is_only_general_on_field() -> bool:
	var is_only_general_on_field = true
	for card in field.get_occupying_cards():
		if "General" in card.get_property("Type") and not_same_card(card, current_card): 
			is_only_general_on_field = false
	return is_only_general_on_field

func is_general(card) -> bool:
	var type = card.get_property("Type")
	return "General" in type

func not_same_card(card1, card2) -> bool:
	return card1.get_property("Name") != card2.get_property("Name")

func shofet_bonus() -> int:
	var bonus = -1
	for card in field.get_occupying_cards():
		if "Shofet" in card.get_property("Type"):
			bonus += 1
	return bonus

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
