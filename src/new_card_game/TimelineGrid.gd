extends BoardPlacementGrid


func get_slot_from_era(era: String):
	match era:
		"Tanna":
			return get_slot(0)
		"Amora":
			return get_slot(1)
		"Gaon":
			return get_slot(2)
		"Rishon":
			return get_slot(3)
		"Acharon":
			return get_slot(4)
		_:
			print("ERROR: Unknown era value")
			return
