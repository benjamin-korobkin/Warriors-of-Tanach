
extends CardFront


func _ready() -> void:
	var _card_text = find_node("CardText")
	# Map your card text label layout here. We use this when scaling
	# The card or filling up its text
	card_labels["Name"] = find_node("Name")
	card_labels["Type"] = find_node("Type")
	card_labels["Description"] = find_node("Description")

	# These set the max (min?) size of each label. This is used to calculate how much
	# To shrink the font when it doesn't fit in the rect.
	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x - 4, STANDARD_FONT_SIZE)
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x - 4, STANDARD_FONT_SIZE)
	card_label_min_sizes["Description"] = Vector2(CFConst.CARD_SIZE.x - 4, STANDARD_FONT_SIZE)

	set_card_rect_min_size()
	attach_card_labels()
	# This is not strictly necessary, but it allows us to change
	# the card label sizes without editing the scene
func set_card_rect_min_size():
	for l in card_label_min_sizes:
		card_labels[l].rect_min_size = card_label_min_sizes[l]

# This stores the maximum size for each label, when the card is at its
# standard size.
# This is multiplied when the card is resized in the viewport.
func attach_card_labels():
	for label in card_labels:
		match label:
			"Power":
				original_font_sizes[label] = STANDARD_FONT_SIZE + 1
			"Type":
				original_font_sizes[label] = STANDARD_FONT_SIZE
			"Description":
				original_font_sizes[label] = STANDARD_FONT_SIZE + 1
			"Name":
				original_font_sizes[label] = STANDARD_FONT_SIZE
			_:
				original_font_sizes[label] = 0

# Putting this here to override parent function since we don't 
# plan on shrinking font at all
func _adjust_font_size(
	font: Font,
	text: String,
	label_size: Vector2,
	line_spacing := 3) -> int:
	return 0
