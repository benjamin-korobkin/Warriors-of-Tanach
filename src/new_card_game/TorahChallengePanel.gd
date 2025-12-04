extends Panel

var correct_sage : String = ""
var opening_label : Label
var center_label : Label
var sage_options_container : Control
var reward_options_container : Control
var failure_options_container : Control
var p1 : Node2D

func _ready():
	for button in get_tree().get_nodes_in_group("torah_challenge_buttons"):
		button.connect("pressed", self, "_on_sage_option_button_pressed", [button])
	opening_label = get_node("VBoxContainer/OpeningLabel")
	center_label = get_node("VBoxContainer/CenterLabel")
	sage_options_container = get_node("VBoxContainer/SageOptionsContainer")
	reward_options_container = get_node("VBoxContainer/RewardOptionsContainer")
	failure_options_container = get_node("VBoxContainer/FailureOptionsContainer")
	

func _on_sage_option_button_pressed(button):
	opening_label.set_visible(false)
	sage_options_container.set_visible(false)
	if correct_sage == "":
		print("DEBUG: Correct sage text is empty") # Do nothing, text not ready yet
	elif button.text == correct_sage:
		display_reward_options()
	else:
		display_failure()


# Display the torah challenge panel with quote from card. Names from p2 BD.
# Param1: card to replace player's
func _on_Player2_replacing_p1_card(replacement_card) -> void:
	## set_visible(true) in p2 script to ensure we wait for player
	# get all names from the BD
	opening_label.set_visible(true)
	sage_options_container.set_visible(true)
	correct_sage = replacement_card.get_property("Name")
	var p2_beit_din = cfc.NMAP.board.get_node("FieldTimelineContainer/FieldHBox2/FieldGrid2")
	var sage_names = []
	for card in p2_beit_din.get_occupying_cards():
		sage_names.append(card.get_property("Name"))
	# Randomize order of names
	sage_names.shuffle()
	sage_options_container = get_node("VBoxContainer/SageOptionsContainer")
	sage_options_container.get_node("SageOption1").text = sage_names[0]
	sage_options_container.get_node("SageOption2").text = sage_names[1]
	sage_options_container.get_node("SageOption3").text = sage_names[2]
	var quote = replacement_card.get_property("Teaching")
	center_label.text = quote
	_set_on_top(true)
	
func display_reward_options():
	center_label.text = "Correct! Select a reward below."
	p1 = cfc.NMAP.board.get_node("TurnQueue/Player1")
	if p1.get_hand().is_full():
		reward_options_container.get_node("EarnCardOption").set_visible(false)
	else:
		reward_options_container.get_node("EarnCardOption").set_visible(true)
	reward_options_container.set_visible(true)
	

## TODO: Add "continue" button so user clearly first sees they chose wrong
func display_failure():
	center_label.text = "Incorrect"
	failure_options_container.set_visible(true)

func _on_EarnCardOption_pressed() -> void:
	p1.get_hand().draw_card()
	_close(reward_options_container)

func _on_EarnMeritsOption_pressed() -> void:
	p1.add_merits(5)
	_close(reward_options_container)
	
func _on_ContinueButton_pressed() -> void:
	_close(failure_options_container)

func _close(container : Control):
	container.set_visible(false)
	set_visible(false)
