class_name ActionsMenu
extends PopupMenu

var board
var field
var p1
var p2
var current_card: Card

signal moved_to_field

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
	field = board.get_node("FieldContainer/FieldHBox1/FieldGrid1")
	p1 = board.get_node("TurnQueue/Player1")
	p2 = board.get_node("TurnQueue/Player2")


## TODO: Change cancel button to big X on corner of popup menu
func _on_CancelButton_pressed() -> void:
	hide()


func _on_SelectButton_pressed() -> void:
	p1.current_card.move_to(board, -1, field.find_available_slot())
	p1.current_card.set_is_faceup(false)
	p1.current_card.set_is_viewed(true)
	p1.current_card.set_in_p1_field(true)
	hide()
	emit_signal("moved_to_field", 1)
	p1.finish_turn()
