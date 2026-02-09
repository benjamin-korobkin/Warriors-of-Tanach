extends Board

onready var tutorial_panel = $CanvasLayer/TutorialPanel
onready var tutorial_label = tutorial_panel.get_node("CenterContainer/VBoxContainer/TutorialLabel")
onready var tutorial_next_button = tutorial_panel.get_node("CenterContainer/VBoxContainer/NextButton")

var current_step = -1
var tutorial_state = "WAITING_FOR_NEXT" setget set_tutorial_state, get_tutorial_state
var node_to_reveal = null
var tut_panel_pos = "center"


onready var tutorial_steps = [
	{"text": """ 
		This grid in the center is the Torah Timeline. 
		It contains 5 slots, one for each of the following
		5 eras: Tanna, Amora, Gaon, Rishon, and Acharon. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $FieldContainer/TimelineGrid,
		"preset":"center_top"},
	{"text": """
		 To put cards in the Timeline,
		 you need Merits. 
		 You can earn Merits by putting cards in your 
		 Beit Midrash. More on that shortly. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		You get 2 actions per turn. Actions include:
		- Drawing a card
		- Putting a card in the Beit Midrash
		- Placing a card in the Timeline
		- Challenging an opponent's card
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		The panel on the left shows remaining actions 
		and Merits for you and your opponent.
		Your actions & Merits are on the top (P1).
		Your opponent's are on the bottom (P2).
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $Counters, "preset":""},
	{"text": """The deck on the left is shared between you and 
		your opponent. Click it to draw a card. 
		""", "state": "WAITING_FOR_DRAW", "reveal_node": $Deck, "preset":""},
	{"text": """Notice you have one action left 
		after drawing a card. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		The grid below the Timeline is your BEIT MIDRASH. 
		At the start of each of your turns, you earn
		1 merits for each Sage here, up to 3 Merits. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $FieldContainer/FieldHBox1, 
		"preset":""},
	{"text": """Your opponent has a Beit Midrash as well
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $FieldContainer/FieldHBox2, 
		"preset":"top_right"},
	{"text": """Now, click your Sage card and click Beit Midrash. 
		""", "state": "WAITING_FOR_BM", "reveal_node": null, "preset":""},
	{"text": """Note: In this tutorial, your cards are shown 
		faceup in the Beit Midrash for simpler viewing. 
		In the main game, they will be facedown.
		You'll still be able to view them.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """You've used 2 actions. 
		Now it's the opponent's turn...
		""", "state": "WAITING_FOR_AI", "reveal_node": null, "preset":""},
	{"text": """Your turn again. 
		Notice you received 1 Torah Merit 
		because you have 1 Sage 
		in your Beit Midrash.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		Go ahead and draw a card again
		""", "state": "WAITING_FOR_DRAW", "reveal_node": null, "preset":""},
	{"text": """ 
		Mazal tov! You got a Tanach card.
		These perform unique actions that can give you
		an advantage.
		Note: Tanach cards cost no action to use.
		Click on it to use it. 
		""", "state": "WAITING_FOR_TANACH", "reveal_node": $Discard, "preset":""},
	{"text": """
		Every 6 turns, you and your opponent receive 
		a random Tanach card. As you just saw, some are 
		within the deck as well.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		The text in the top left corner shows how many
		turns left until the next Tanach cards are distributed
		""", "state": "WAITING_FOR_NEXT", "reveal_node": $TanachIntervalLabel, "preset":""},
	{"text": """
		Put one of your new Sages into the Beit Midrash.
		""", "state": "WAITING_FOR_BM", "reveal_node": null, "preset":""},
	{"text": """
		It's your opponent's turn again...
		""", "state": "WAITING_FOR_AI", "reveal_node": null, "preset":""},
	{"text": """
		Opponent turn over. Notice your Merits increased.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	# P1 and P2 have 2 cards in BM, P1 has 1 sage in hand. P1 has 3 Merits, P2 1.
	{"text": """
		Let's do this again. 
		Put your remaining Sage in the Beit Midrash.
		""", "state": "WAITING_FOR_BM", "reveal_node": null, "preset":""},
	{"text": """
		Draw a card once more.
		""", "state": "WAITING_FOR_DRAW", "reveal_node": null, "preset":""},
	{"text": """
		Time to wait for your opponent's turn again...
		""", "state": "WAITING_FOR_AI", "reveal_node": null, "preset":""},
	{"text": """
		It's been 6 turns, so you've each received 
		a Tanach card!
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		Also, you now have 5 Merits. It's enough to put a 
		Sage in the Timeline.
		Click the Sage in your hand and select Timeline.
		""", "state": "WAITING_FOR_TIMELINE", "reveal_node": null, "preset":""},
	{"text": """
		Baruch Hashem! If you have the majority of Sages
		in the Timeline when it's full, you win the game.
		Next, we'll talk about replacing opponent cards 
		in the Timeline.
		
		First, draw another card to finish your turn.
		""", "state": "WAITING_FOR_DRAW", "reveal_node": null, "preset":""},
	{"text": """
		It's your opponent's turn again...
		They're about to put a card into the Timeline.
		""", "state": "WAITING_FOR_AI", "reveal_node": null, "preset":""},
	{"text": """Notice when your opponent puts cards 
		in the Timeline, they are shown upside-down.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		Go ahead and use your Tanach card. You'll need it.
		""", "state": "WAITING_FOR_TANACH", "reveal_node": null, "preset":""},
	{"text": """	When your Beit Midrash contains 3 Sages, 
		it gains the status of a BEIT DIN. 
		With a Beit Din, you can replace a Sage 
		in the Timeline, if you fulfill both of the 
		following conditions...
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """	
		1. You have (at least) 5 Merits to spend. OR, 
		   used the Moshe Rabbeinu card (lucky you).
		2. A Sage in your Beit Din matches
		   the era of the Sage you are replacing.
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """Click the Acharon (Rav Nachman of Breslov)
		in your Beit Din and select Timeline to 
		put your opponent's card into Olam Haba 
		and replace it.
		""", "state": "WAITING_FOR_TIMELINE", "reveal_node": null, "preset":""},
	{"text": """Well done! Keep in mind your opponent can also 
		replace your cards. This is where 
		the Challenge action comes in handy. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """
		Click the Sage in your hand and select Challenge. 
		Then select a card in your opponent's Beit Din.
		""", "state": "WAITING_FOR_CHALLENGE", "reveal_node": null, "preset":""},
	{"text": """As you just saw, both cards were shown and then
		sent to Olam haba (discard pile). 
		When challenging, if your Sage is of a higher number 
		era than your opponent, you earn Merits. 
		You can find more details on the main game page. 
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":""},
	{"text": """You now have everything you need 
		to start playing! Come back here whenever you need
		a refresher. 
		
		Press the 'next' button to return to the main menu
		""", "state": "WAITING_FOR_NEXT", "reveal_node": null, "preset":"center"},
	]


func _ready() -> void:
	cfc.map_node(self)
#	cfc.game_settings.focus_style = CFInt.FocusStyle.SCALED
#	$ScalingFocusOptions.selected = cfc.game_settings.focus_style
	load_cards()
	tutorial_label.text = """
		Welcome to the Torah Timeline tutorial! 
		In this game, your goal is to place SAGE 
		cards into the Timeline and have the majority
		when the Torah Timeline is full. 
		Click NEXT to continue.
		"""
	_adjust_tutorial_panel("center")
	
	counters = $Counters
	$TurnQueue.initialize()

func advance_tutorial():
	current_step += 1
	if current_step < tutorial_steps.size():
		set_tutorial_state(tutorial_steps[current_step]["state"])
		tutorial_label.text = tutorial_steps[current_step]["text"]
		node_to_reveal = tutorial_steps[current_step]["reveal_node"]
		tut_panel_pos = tutorial_steps[current_step]["preset"]
		reveal_node(node_to_reveal)
		_adjust_tutorial_panel(tut_panel_pos)
	else:
		cfc.quit_game()
		get_parent().get_tree().change_scene("res://src/new_card_game/MainMenu.tscn")


func _on_NextButton_pressed() -> void:
	advance_tutorial()
	
func reveal_node(node: Node) -> void:
	if node:
		node.set_visible(true)
		print("SHOW NODE: " + node.get_name())
		
## Our custom function to load the cards
## Difference between this and board is 
## we don't shuffle the deck, so we'll have to
## order the actual to our needs
func load_cards() -> void:
	var card_array := []
	var card_options := []
	for ckey in cfc.card_definitions.keys():
		card_options.append(ckey)
	for c in card_options:
		card_array.append(cfc.instance_card(c))
	var tcard_counter = 0
	for card in card_array:
		var target_deck = cfc.NMAP.deck
		if card.card_type == "Tanach":
			if tcard_counter < 2:
				tcard_counter += 1
			else:
				target_deck = cfc.NMAP.tdeck
		target_deck.add_child(card)
		card._determine_idle_state()
		
func _adjust_tutorial_panel(anchor : String) -> void:
	match anchor:
		"center_top":
			tutorial_panel.set_anchors_and_margins_preset(Control.PRESET_CENTER_TOP, 
			Control.PRESET_MODE_KEEP_SIZE)
		"top_right":
			tutorial_panel.set_anchors_and_margins_preset(Control.PRESET_TOP_RIGHT, 
			Control.PRESET_MODE_KEEP_SIZE)
			
		"center":
			tutorial_panel.set_anchors_and_margins_preset(Control.PRESET_CENTER, Control.PRESET_MODE_KEEP_SIZE)
		_:
			pass
	
	tutorial_next_button.set_visible(true)	
	if get_tutorial_state() != "WAITING_FOR_NEXT":
		tutorial_next_button.set_visible(false)
	
	
func set_tutorial_state(state : String):
	tutorial_state = state
	
func get_tutorial_state() -> String:
	return tutorial_state

## I'll probably remove this later
func _on_ScalingFocusOptions_item_selected(index: int) -> void:
	cfc.set_setting('focus_style', index)

func _on_TurnQueue_turn_counter_updated(turn_counter) -> void:
	$TanachIntervalLabel.text = "Turns till Tanach card: " + str(turn_counter)

func _on_Exit_Game_pressed() -> void:
	cfc.quit_game()
	get_tree().change_scene("res://src/new_card_game/MainMenu.tscn")
