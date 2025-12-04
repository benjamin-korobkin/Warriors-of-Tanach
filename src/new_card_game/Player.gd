class_name Player
extends Node2D

signal action_completed

onready var board = get_parent().get_parent()
 
var current_card : Card
var hand : Area2D
var field : PanelContainer
var opponent : Node2D
var has_moved : bool
var points : int = 0
var player_name : String


func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	

func play_turn():
	pass
	
func finish_turn():
	has_moved = false
	
func draw_card():
	hand.draw_card()

# TODO
func update_points(amt : int):
	pass

func turn_over():
	get_parent().check_turn_over()

func set_current_card(card):
	current_card = card
	
func get_field():
	return field
	
func get_hand():
	return hand
