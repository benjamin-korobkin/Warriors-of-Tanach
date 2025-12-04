# new_card_game/Deck.gd, copied from CGFDeck.gd
extends Pile

#signal draw_card(deck)
signal is_empty(deck)

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")

