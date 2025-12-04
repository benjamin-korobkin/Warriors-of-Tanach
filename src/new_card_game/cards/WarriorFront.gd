extends "res://src/new_card_game/CardFront.gd"


func _ready() -> void:
	card_labels["Type"] = find_node("Type")
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x - 4, STANDARD_FONT_SIZE)
	card_labels["Name"] = find_node("Name")
	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x - 4, STANDARD_FONT_SIZE + 2)
	card_labels["Power"] = find_node("Power")
	card_label_min_sizes["Power"] = Vector2(CFConst.CARD_SIZE.x - 4,STANDARD_FONT_SIZE)
	# Repeat these methods to get in the card_labels.rect_min_size
	# and original_font_sizes iterables
	set_card_rect_min_size()
	attach_card_labels()
