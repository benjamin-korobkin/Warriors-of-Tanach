extends Card

export(CardID.ID) var card_id := 0

var board : Control
var actions_menu : PopupMenu

# No easy way to get grid as parent, so using attributes instead.
var in_p1_field: bool = false setget set_in_p1_field,get_in_p1_field
var in_p2_field: bool = false setget set_in_p2_field,get_in_p1_field

var modifiers = {
	"shofet_bonus": 0,
	"king_bonus": 0,
}

func _ready() -> void:
	._ready()
	assert(card_id != 0, "CardID not set for card: " + name)
	# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_Card_gui_input")


func _on_Card_gui_input(event) -> void:
	board = cfc.NMAP.board
	var p1 = board.get_node("TurnQueue/Player1")
	if event is InputEventMouseButton and cfc.NMAP.has("board") and not p1.get_has_moved():
		var hand1 = board.get_node("Hand1")
		actions_menu = board.get_node("ActionsMenu")
		p1.set_current_card(self)
		if get_parent() == hand1 and not in_p1_field:
			actions_menu.popup()
		
		## TUTORIAL CODE
		#tutorial_checks()

func tutorial_checks():
	if board.get_name() == "Tutorial":
		#select_button.set_disabled(false)
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

