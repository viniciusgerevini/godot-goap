extends Node

var _state = {
}


func get_state(state_name, default = null):
	return _state.get(state_name, default)


func set_state(state_name, value):
	_state[state_name] = value


func clear_state():
	_state = {}


func get_elements(group_name):
	return self.get_tree().get_nodes_in_group(group_name)


func get_closest_element(group_name, reference):
	var elements = get_elements(group_name)
	var closest_element
	var closest_distance = 10000000

	for element in elements:
		var distance = reference.position.distance_to(element.position)
		if  distance < closest_distance:
			closest_distance = distance
			closest_element = element

	return closest_element


func console_message(object):
	var console = get_tree().get_nodes_in_group("console")[0] as TextEdit
	console.text += "\n%s" % str(object)
	console.set_caret_line(console.get_line_count())
