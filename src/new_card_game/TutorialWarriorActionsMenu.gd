class_name TutorialActionsMenu
extends PopupMenu

var board
var timeline
var field
var p1
var p2
var current_card: Card
var challenge_panel

signal moved_to_field

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	field = board.get_node("FieldContainer/FieldHBox1/FieldGrid1")
	timeline = board.get_node("FieldContainer/TimelineGrid")
	p1 = board.get_node("TurnQueue/Player1")
	p2 = board.get_node("TurnQueue/Player2")
	challenge_panel = board.get_node("ChallengePanel")
	

func _on_FieldButton_pressed() -> void:
	if p1.can_deduct_action():
		p1.deduct_action()
		p1.current_card.move_to(board, -1, field.find_available_slot())
		p1.current_card.set_is_faceup(true)
		p1.current_card.set_is_viewed(true)
		p1.current_card.set_in_p1_field(true)
		hide()
		emit_signal("moved_to_field", 1)
		p1.turn_over()
		## TUTORIAL
		board.advance_tutorial()
	else:
		print("ERROR: Beit Midrash button pressed with no actions available")
	
func _on_TimelineButton_pressed() -> void:
	var era = p1.current_card.get_property("Era")
	var slot = timeline.get_slot_from_era(era)
	if p1.can_deduct_action():  # TODO: Do we need this condition?
		if p1.moshe_effect_enabled:
			p1.moshe_effect_enabled = false
		else:
			p1.deduct_action()
			p1.spend_merits()
		if slot.occupying_card:
			slot.occupying_card.move_to(cfc.NMAP.discard)
			p2.cards_in_timeline -= 1
			# TODO: TEST
			yield(owner.get_tree().create_timer(0.75), "timeout")
		p1.current_card.move_to(board, -1, slot)
		# for when moving from BM to TT
		p1.current_card.set_in_p1_field(false)
		p1.current_card.set_is_faceup(true)
		p1.cards_in_timeline += 1
		hide()
		p1.turn_over()
		## TUTORIAL
		board.advance_tutorial()

## TODO: Change cancel button to big X on top left of popup menu
func _on_CancelButton_pressed() -> void:
	hide()

func _on_ChallengeButton_pressed() -> void:
	if p1.can_deduct_action():
		hide()
		challenge_panel.popup()
		p1.set_is_challenging(true)
	else:
		print("ERROR: CHALLENGE BUTTON PRESSED WITH NO ACTIONS REMAINING")
	
	
	
