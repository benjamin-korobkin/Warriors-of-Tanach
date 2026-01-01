extends Board


onready var field_grid1 = $FieldContainer/FieldHBox1/FieldGrid1
onready var field_grid2 = $FieldContainer/FieldHBox2/FieldGrid2
onready var p1_points_label = field_grid1.get_node("Control/Label")
onready var p2_points_label = field_grid2.get_node("Control/Label")


func _ready() -> void:
	cfc.map_node(self)
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	cfc.game_settings.fancy_movement = false
	cfc.game_settings.hand_use_oval_shape = false
	cfc.game_settings.focus_style = CFInt.FocusStyle.VIEWPORT
	$TurnQueue/Player1.connect("points_updated", self, "_on_points_updated")
	$TurnQueue/Player2.connect("points_updated", self, "_on_points_updated")
	load_cards()
	$TurnQueue.initialize()
	

func _on_points_updated(player, points : int):
	if player == $TurnQueue/Player1:
		p1_points_label.text = "Points: " + str(points)
	if player == $TurnQueue/Player2:
		p2_points_label.text = "Points: " + str(points)

func _on_OvalHandToggle_toggled(_button_pressed: bool) -> void:
	pass

# Reshuffles all Card objects created back into the deck
func _on_ReshuffleAllDeck_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.deck)

func reshuffle_all_in_pile(pile = cfc.NMAP.deck):
	for c in get_tree().get_nodes_in_group("cards"):
		if c.get_parent() != pile and c.state != Card.CardState.DECKBUILDER_GRID:
			c.move_to(pile)
			yield(get_tree().create_timer(0.1), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = pile.get_top_card()
	if last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	pile.shuffle_cards()


# Button to change focus mode
func _on_ScalingFocusOptions_item_selected(index) -> void:
	cfc.set_setting('focus_style', index)


func _on_Debug_toggled(button_pressed: bool) -> void:
	cfc._debug = button_pressed

## Our custom function to load the cards
func load_cards() -> void:
	var card_array := []
	var card_options := []
	for ckey in cfc.card_definitions.keys():
		card_options.append(ckey)
	for c in card_options:
		card_array.append(cfc.instance_card(c))
	## Randomize card_array
	#CFUtils.shuffle_array(card_array)
	for card in card_array:
		cfc.NMAP.deck.add_child(card)
		card._determine_idle_state()

# Loads a sample set of cards to use for testing
func load_test_cards(gut := true) -> void:
	var extras = 29
	# Hardcoded the card order because for some reason, GUT on low-powered VMs
	# ends up with a different card order, even when the seed is the same.
	var gut_cards := [
		"Test Card 3",
		"Multiple Choices Test Card",
	]
	var test_card_array := []
	if gut:
		for card in gut_cards:
			test_card_array.append(cfc.instance_card(card))
	else:
		var test_cards := []
		for ckey in cfc.card_definitions.keys():
			if ckey != "Spawn Card":
				test_cards.append(ckey)
		for _i in range(extras):
			if not test_cards.empty():
				var random_card_name = \
						test_cards[CFUtils.randi() % len(test_cards)]
				test_card_array.append(cfc.instance_card(random_card_name))
		# 11 is the cards GUT expects. It's the testing standard
		if extras == 2:
		# I ensure there's of each test card, for use in GUT
			for card_name in test_cards:
				test_card_array.append(cfc.instance_card(card_name))
	for card in test_card_array:
		cfc.NMAP.deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()

func _on_DeckBuilder_pressed() -> void:
	cfc.game_paused = true
	$DeckBuilderPopup.popup_centered_minsize()

func _on_DeckBuilder_hide() -> void:
	cfc.game_paused = false

func _on_BackToMain_pressed() -> void:
	cfc.quit_game()
	get_tree().change_scene("res://src/custom/MainMenu.tscn")

func _on_ActionsMenu_index_pressed(index: int) -> void:
	print(index)
	
