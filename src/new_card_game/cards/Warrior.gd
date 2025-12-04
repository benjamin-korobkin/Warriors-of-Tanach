extends Card

var actions_menu : PopupMenu
# var type : String
var board : Control
var select_button : Button
# No easy way to get grid as parent, so using attributes instead.
var in_p1_field: bool = false setget set_in_p1_field,get_in_p1_field
var in_p2_field: bool = false setget set_in_p2_field,get_in_p1_field

## TODO: Refactor this later, update the control flow
func _on_Card_gui_input(event) -> void:
	board = cfc.NMAP.board
	var player1 = board.get_node("TurnQueue/Player1")

	if event is InputEventMouseButton and cfc.NMAP.has("board") and not player1.turn_over:
		var hand1 = board.get_node("Hand1")
		
		#var field = board.get_node("FieldTimelineContainer/FieldHBox1/FieldGrid1")
		actions_menu = board.get_node("ActionsMenu")
		select_button = actions_menu.get_node("VBoxContainer/HBoxContainer/SelectButton")
		player1.set_current_card(self)
		if get_parent() == hand1 and not in_p1_field:
			actions_menu.popup()
		
		## TUTORIAL CODE
		tutorial_checks()

# TODO: Might use for the tutorial
func tutorial_checks():
	if board.get_name() == "Tutorial":
		select_button.set_disabled(false)
		match board.get_tutorial_state():
			"":
				pass
			_:
				pass			

			
func set_in_p1_field(value):
	in_p1_field = value
	
func get_in_p1_field():
	return in_p1_field

func set_in_p2_field(value):
	in_p2_field = value

func get_in_p2_field():
	return in_p2_field
