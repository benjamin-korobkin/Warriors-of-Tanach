class_name Player
extends Node2D

signal points_updated(player, points)
signal action_completed

const ONLY_GENERAL_BONUS = 5

onready var board = get_parent().get_parent()
 
var current_card : Card
var hand : Area2D
var field : BoardPlacementGrid
var opponent : Node2D
var has_moved : bool setget set_has_moved, get_has_moved
var total_points : int = 0
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
	current_card.set_is_faceup(true)
	current_card.set_card_rotation(0)
	yield(calculate_points(), "completed")
	current_card.set_is_newly_placed(false)
	
func calculate_points():
	var points : int = 0
	implement_condition(current_card)
	for card in field.get_occupying_cards():
		points += card.get_property("Power")
	yield(get_tree().create_timer(0.6), "timeout")
	update_points(points)


func update_points(points : int):
	total_points = points
	emit_signal("points_updated", self, total_points)

func set_current_card(card):
	current_card = card
	
func get_field():
	return field
	
func get_hand():
	return hand
	
func set_has_moved(moved : bool):
	has_moved = moved

func get_has_moved():
	return has_moved
	
	
func implement_condition(current_card) -> void:
	var field_cards = field.get_occupying_cards()
	var opponent_cards = opponent.field.get_occupying_cards()
	var card_type = current_card.get_property("Type")
	var power = current_card.get_property("Power")
	
	## Shofet Effect
	if "Shofet" in card_type:
		var bonus = shofet_bonus()
		for card in field_cards:
			if "Shofet" in card.get_property("Type"):
				var base_power = card.get_property("Base_Power")
				card.modify_property("Power", base_power + bonus)

	
	## General to King Effect
	if is_general(current_card):
		for card in field_cards:
			var name = card.get_property("Name")
			if "David" in name:
				add_pow(card, 3)
			elif "Shaul" in name:
				add_pow(card, 2)
			elif "Asa" in name:
				add_pow(card, 1)
			## TODO test & improve the code for this card
			elif "Elazar ben Dodo" in name and \
				card.get_property("Power") == 7:
				add_pow(card, -ONLY_GENERAL_BONUS)
		for card in opponent_cards:
			var name = card.get_property("Name")
			if "David" in name:
				add_pow(card, -2)
			elif "Shaul" in name:
				add_pow(card, -1)

	var card_name = current_card.get_property("Name")
	var opp_card = get_opponent_played_card()
	var prev_card = get_prev_played_card()
	
	match card_name:
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
			if is_only_general():
				add_pow(current_card, ONLY_GENERAL_BONUS)
		"Ittai":
			if prev_card != null and "General" in prev_card.get_property("Type"):
				add_pow(current_card, 2)
		"Benaiah":
			if "General" in opp_card.get_property("Type"):
				add_pow(current_card, 3)
		"Osniel ben Kenaz":
			for card in field_cards:
				if "Shofet" in card.get_property("Type") and not_same_card(card, current_card):
					var base_power = card.get_property("Base_Power")
					card.modify_property("Power", base_power * 2)
		"Toleh ben Puah":
			if "Shofet" in opp_card.get_property("Type"):
				add_pow(current_card, 2)
		_:
			pass


func get_opponent_played_card() -> Card:
	for card in opponent.field.get_occupying_cards():
		if card.get_is_newly_placed():
			return card
	print("ERROR: Couldn't get opponent's played card")
	return null
	
func get_prev_played_card() -> Card:
	return field.get_previous_card(current_card)
	
func is_only_general() -> bool:
	var is_only_general = true
	for card in field.get_occupying_cards():
		if "General" in card.get_property("Type") and not_same_card(card, current_card): 
			is_only_general = false
	return is_only_general

func add_pow(card, power):
	var p = card.get_property("Power")
	card.modify_property("Power", p + power)

func king_effect(amt_add, amt_sub):
	for card in field.get_occupying_cards():
		if is_general(card):
			add_pow(current_card, amt_add)
	for card in opponent.field.get_occupying_cards():
		if is_general(card) and not card.get_is_newly_placed():
			add_pow(current_card, amt_sub)

func is_general(card) -> bool:
	var type = card.get_property("Type")
	return "General" in type or "Soldier" in type 

func not_same_card(card1, card2) -> bool:
	return card1.get_property("Name") != card2.get_property("Name")

func shofet_bonus() -> int:
	var bonus = -1
	for card in field.get_occupying_cards():
		if "Shofet" in card.get_property("Type"):
			bonus += 1
	return bonus
