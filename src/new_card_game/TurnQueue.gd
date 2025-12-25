extends Node2D
class_name TurnQueue

const TOTAL_ROUNDS : int = 5
const CARDS_DRAWN_AT_START : int = 3

signal game_won(player)

onready var game_over : bool = false
onready var active_player : Node2D setget set_active_player, get_active_player
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true
onready var turn_over = false
onready var current_round : int = 1


func initialize():
	for _i in range(CARDS_DRAWN_AT_START):
		yield(get_tree().create_timer(0.4), "timeout")
		p1.hand.draw_card()
		yield(get_tree().create_timer(0.4), "timeout")
		p2.hand.draw_card()
	set_active_player(p1)
	active_player.play_turn()

## We have 2 methods for taking turns: turn_over and round_over
## turn_over for each player placing a card. round_over once both players 
## have placed a card

func turn_over():
	if get_active_player() == p1:
		set_active_player(p2)
		get_active_player().play_turn()
	if p1.get_has_moved() and p2.get_has_moved():
		# Reveal both cards and wait for points calculation to complete
		p1.reveal_card()
		p2.reveal_card()
		p1.update_points()
		p2.update_points()
		round_over()


func round_over():
	if current_round >= TOTAL_ROUNDS:
		var winner
		if p1.get_total_points() > p2.get_total_points():
			winner = p1
		elif p1.get_total_points() < p2.get_total_points():
			winner = p2
		else:
			winner = null
		if winner:
			emit_signal("game_won", winner.get_name())
		else: ## TODO: Game ends in draw
			emit_signal("game_won", "DRAW")
		game_over = true
	else:
		current_round += 1
		set_active_player(p1)
		get_active_player().play_turn()

func set_active_player(player):
	active_player = player
	
func get_active_player():
	return active_player
