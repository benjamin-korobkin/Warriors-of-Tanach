extends Panel


func _on_game_won(player) -> void:
	set_visible(true)
	var winner = "You" if player=="Player1" else "Opponent"
	$CenterContainer/GameOverLabel.text = "{p} won!".format({"p": winner})
	_set_on_top(true)


func _on_MenuButton_pressed() -> void:
	cfc.quit_game()
	get_parent().get_tree().change_scene("res://src/custom/MainMenu.tscn")


func _on_PlayAgainButton_pressed() -> void:
	cfc.reset_game() 
