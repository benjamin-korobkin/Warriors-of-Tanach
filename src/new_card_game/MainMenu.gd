extends Panel

# The time it takes to switch from one menu tab to another
const menu_switch_time = 0.2

onready var h_buttons := $MainMenu/VBox/Center/HButtons
onready var main_menu := $MainMenu
onready var loading_label := $MainMenu/VBox/LoadingLabel
#onready var settings_menu := $SettingsMenu


func _ready() -> void:

	for option_button in h_buttons.get_children():
		if option_button.has_signal('pressed'):
			option_button.connect('pressed', self, 'on_button_pressed', [option_button.name])
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, '_on_Menu_resized')


func on_button_pressed(_button_name : String) -> void:
#	loading_label.set_visible(true)
	match _button_name:
		"Tutorial":
			# warning-ignore:return_value_discarded
			get_tree().change_scene(CFConst.PATH_CUSTOM + 'Tutorial.tscn')
		"Start":
			cfc._debug = false
			# warning-ignore:return_value_discarded
			get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')
		"DebugMode":
			cfc._debug = true
			# warning-ignore:return_value_discarded
			get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')
		"Exit":
			get_tree().quit()

func _on_Menu_resized() -> void:
	for tab in [main_menu]: #, deck_builder, card_library]:
		if is_instance_valid(tab):
			tab.rect_size = get_viewport().size
			if tab.rect_position.x < 0.0:
					tab.rect_position.x = -get_viewport().size.x
			elif tab.rect_position.x > 0.0:
					tab.rect_position.x = get_viewport().size.x
