class_name Player
extends Node2D

signal points_updated(player, total_points)
signal action_completed

onready var board = get_parent().get_parent()
 
var current_card : Card
var hand : Area2D
var field : PanelContainer
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
	calculate_points()
	
func calculate_points():
	var points : int = 0
	implement_condition(current_card)
	for card in field.get_occupying_cards():
		points += card.get_property("Power")
	
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
	## TODO Use current_card.modify_property("Power", 0) function to update the value
	var field_cards = field.get_occupying_cards()
	var opponent_cards = opponent.field.get_occupying_cards()
	var card_type = current_card.get_property("Type")
	var power = current_card.get_property("Power")
	## TODO: Update the method such that it increases the value of each Shofet by 1. But 
	## the current Shofet should be increased by 1 multiplied by the number of other shofets.
	if "Shofet" in card_type:
		var bonus = shofet_bonus()
		for card in field_cards:
			if "Shofet" in card.get_property("Type"):
				card.modify_property("Power", power + bonus)
				
	if "Prophet" in card_type:
		for card in field_cards:
			if "Avraham Avinu" in card.get_property("Name") and not_same_card(current_card, card):
				add_pow(card, 3)
	
	if is_general_or_soldier(current_card):
		for card in field_cards:
			var name = card.get_property("Name")
			if "David" in name:
				add_pow(card, 3)
			elif "Shaul" in name or "Asa" in name:
				add_pow(card, 2)
		for card in opponent_cards:
			var name = card.get_property("Name")
			if "David" in name:
				add_pow(card, -2)
			elif "Shaul" in name:
				add_pow(card, -1)
			
	
	var card_name = current_card.get_property("Name")
	
	match card_name:
		"Yehoshua":
			for card in field_cards:
				if "Moshe Rabbeinu" in card.get_property("Name"):
					add_pow(current_card, 3)
		"Moshe Rabbeinu":
			for card in field_cards:
				var name = card.get_property("Name")
				if "Yehoshua" in name:
					add_pow(card, 3)
				elif "Aharon" in name:
					add_pow(current_card, 5)
				elif "Chur" in name:
					add_pow(current_card, 5)
		"Aharon":
			for card in field_cards:
				if "Moshe Rabbeinu" in card.get_property("Name"):
					add_pow(card, 5)
		"Chur":
			for card in field_cards:
				if "Moshe Rabbeinu" in card.get_property("Name"):
					add_pow(card, 5)
		"David HaMelech":
			for card in field_cards:
				if is_general_or_soldier(card):
					add_pow(current_card, 3)
			for card in opponent_cards:
				if is_general_or_soldier(card):
					add_pow(current_card, -2)
		"Yoav":
			for card in opponent_cards:
				if "Benaiah" in card.get_property("Name"):
					add_pow(current_card, -1)
		"Benaiah":
			for card in opponent_cards:
				if "Yoav" in card.get_property("Name"):
					add_pow(card, -1)
		"Barak":
			for card in field_cards:
				if "Devorah" in card.get_property("Name"):
					add_pow(current_card, 3)
		"Eliyahu HaNavi":
			for card in field_cards:
				if "Pinchas" in card.get_property("Name"):
					add_pow(card, 3)
		"Pinchas":
			for card in field_cards:
				if "Eliyahu" in card.get_property("Name"):
					add_pow(current_card, 3)
		## TODO: reset to 2 whenever we put down a general. modify_property()
#		"Elazar ben Dodo":
#			var generals_found = false
#			for card in field_cards:
#				if "General" in card.get_property("Type"):
#					generals_found = true
#			if not generals_found:
#				add_pow(current_card, 5)
		_:
			pass
			

func add_pow(card, power):
	var p = card.get_property("Power")
	card.modify_property("Power", p + power)

func is_general_or_soldier(card) -> bool:
	var type = card.get_property("Type")
	return "General" in type or "Soldier" in type 

func not_same_card(card1, card2) -> bool:
	return card1.get_property("Name") != card2.get_property("Name")
	
#func is_only_shofet(card) -> bool:
#	for c in field.get_occupying_cards():
#		if "Shofet" in c.get_property("Type") and not_same_card(card, c):
#			return false
#	return true
	
func shofet_bonus() -> int:
	var bonus = -1
	for card in field.get_occupying_cards():
		if "Shofet" in card.get_property("Type"):
			bonus += 1
	return bonus

