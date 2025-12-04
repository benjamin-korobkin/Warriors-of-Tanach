extends Counters

# * The `counters_container` has to point to the scene path, relative to your
#	counters scene, where each counter will be placed.
# * value_node specified the name of the label which holds
#	the value of the counter as displayed to the player
# * The needed_counters dictionary has one key per counter used in your game
#	Each value hold a dictionary with details about this counter.
#	* The key matching `value_node` will be used to set the starting
#		value of this counter
#	* All other keys specified have to match a label node name in the counter scene
#		and their value will be set as that label's text.
# * spawn_needed_counters() has to be called at the end, to actually
#	add the specified counters to your counters scene.
func _ready() -> void:
	counters_container = $VBC
	value_node = "Value"
	needed_counters = {
		"Player1_actions_remaining":{
			"CounterTitle": "P1 ACTIONS: ",
			"Value": "2"},
		"Player1_merits": {
			"CounterTitle": "P1 Merits: ",
			"Value": "0/5"},
		"Separator":{
			"CounterTitle":"",
			"Value":""},
		"Player2_actions_remaining":{
			"CounterTitle": "P2 Actions:", #P2 Actions: 
			"Value": "0"}, #0/2
		"Player2_merits": {
			"CounterTitle": "P2 Merits: ",
			"Value": "0/5"},
	}
	# warning-ignore:return_value_discarded
	spawn_needed_counters()

## Taken from mod_counter method in core/Counters.gd

func update_counter(counter_name: String,
		value: String,
		set_to_mod := true,
		check := false,
		requesting_object = null,
		tags := ["Manual"]) -> int:
	var retcode = CFConst.ReturnCode.CHANGED
	if counters.get(counter_name, null) == null:
		retcode = CFConst.ReturnCode.FAILED
	else:
		if set_to_mod and counters[counter_name] == value:
			retcode = CFConst.ReturnCode.OK
		else:
			if not check:
				cfc.flush_cache()
				var prev_value = counters[counter_name]
				_set_counter(counter_name,value)
				emit_signal(
						"counter_modified",
						requesting_object,
						"counter_modified",
						{
							SP.TRIGGER_COUNTER_NAME: counter_name,
							SP.TRIGGER_PREV_COUNT: prev_value,
							SP.TRIGGER_NEW_COUNT: counters[counter_name],
							"tags": tags,
						}
				)
	return(retcode)
	
func _set_counter(counter_name: String, value) -> void:
	counters[counter_name] = value
	_labels[counter_name].text = str(counters[counter_name])
