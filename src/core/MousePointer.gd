# MousePointer.gd
# Handles mouse hover and drag focus for Control-based Card nodes.
# Designed to replace Area2D-based detection.

extends Node

class_name MousePointer

# The card currently focused by the mouse
var current_focused_card: Card = null
# Prevents the mouse from interacting with the board
var is_disabled: bool = false setget set_disabled

# Called when the node enters the scene tree
func _ready() -> void:
	if cfc._debug and has_node("DebugShape"):
		$DebugShape.visible = true

# Called every frame
func _process(_delta: float) -> void:
	if current_focused_card:
		# Keep the card focused if it's still in hand or on board
		if current_focused_card.get_parent() == cfc.NMAP.board \
				and current_focused_card.state == Card.CardState.ON_PLAY_BOARD:
			current_focused_card.state = Card.CardState.FOCUSED_ON_BOARD
		elif current_focused_card.get_parent() == cfc.NMAP.hand1 \
				and current_focused_card.state == Card.CardState.IN_HAND:
			current_focused_card.state = Card.CardState.FOCUSED_IN_HAND

	if cfc.card_drag_ongoing and cfc.card_drag_ongoing != current_focused_card:
		current_focused_card = cfc.card_drag_ongoing

	if cfc._debug and current_focused_card:
		if has_node("DebugShape/current_focused_card"):
			$DebugShape/current_focused_card.text = "MOUSE: " + str(current_focused_card)

# Connect each card's mouse_entered / mouse_exited signals to these
func _on_Card_mouse_entered(card: Card) -> void:
	if is_disabled:
		return
	current_focused_card = card
	card.highlight.set_highlight(true)
	# Optionally raise z_index so the hovered card draws on top
	card.z_index = 100

func _on_Card_mouse_exited(card: Card) -> void:
	if is_disabled:
		return
	if current_focused_card == card:
		current_focused_card = null
	card.highlight.set_highlight(false)
	# Reset z_index if needed
	card.z_index = 0

# Disables the mouse from interacting with cards
func disable() -> void:
	is_disabled = true
	if current_focused_card:
		current_focused_card.highlight.set_highlight(false)
	current_focused_card = null

# Re-enables the mouse
func enable() -> void:
	is_disabled = false

func set_disabled(value: bool) -> void:
	if value:
		disable()
	else:
		enable()
