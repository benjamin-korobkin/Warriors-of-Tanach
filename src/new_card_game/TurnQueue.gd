extends Node2D
class_name TurnQueue

const TOTAL_TURNS : int = 5
const CARDS_DRAWN_AT_START : int = 4

signal game_won(player)

onready var game_over : bool = false
onready var active_player : Node2D setget set_active_player, get_active_player
onready var p1 = $Player1
onready var p2 = $Player2
onready var is_first_turn = true
onready var turn_over = false
onready var current_turn : int = 1


func initialize():
	for _i in range(CARDS_DRAWN_AT_START):
		yield(get_tree().create_timer(0.4), "timeout")
		p1.hand.draw_card()
		yield(get_tree().create_timer(0.4), "timeout")
		p2.hand.draw_card()
	set_active_player(p1)
	active_player.play_turn()


func turn_over():
	if TOTAL_TURNS >= current_turn:
		var winner
		if p1.points > p2.points:
			winner = p1
		elif p1.points < p2.points:
			winner = p2
		else:
			winner = null
		if winner:
			emit_signal("game_won", winner.get_name())
		else: ## TODO: Game ends in draw
			emit_signal("game_won", "No one")
		game_over = true
	else:
		current_turn += 1
		if get_active_player() == p1:
			set_active_player(p2)
		else:
			set_active_player(p1)
			active_player.play_turn()


func set_active_player(player):
	active_player = player
	
func get_active_player():
	return active_player
