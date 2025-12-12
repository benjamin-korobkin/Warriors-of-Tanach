class_name Player
extends Node2D

signal action_completed
signal points_updated(new_total)

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
	yield(get_tree().create_timer(0.6), "timeout")
	get_hand().draw_card()
	get_parent().turn_over()
	
func draw_card():
	hand.draw_card()

func reveal_card():
	current_card.set_is_faceup(true)
	calculate_points()
	
func calculate_points():
	var points : int = 0
	points = current_card.get_property("Power")
	update_points(points)


func update_points(amt : int):
	total_points += amt
	emit_signal("points_updated", total_points)

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
