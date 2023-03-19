extends GoapAction

class_name BuildFirepitAction

const Firepit = preload("res://scenes/firepit.tscn")


func get_clazz(): return "BuildFirepitAction"


func get_cost(_blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {
		"has_wood": true
	}


func get_effects() -> Dictionary:
	return {
		"has_firepit": true
	}


func perform(actor, delta) -> bool:
	var _closest_spot = WorldState.get_closest_element("firepit_spot", actor)

	if _closest_spot == null:
		return false

	if _closest_spot.position.distance_to(actor.position) < 20:
			var firepit = Firepit.instantiate()
			actor.get_parent().add_child(firepit)
			firepit.position = _closest_spot.position
			firepit.z_index = _closest_spot.z_index
			WorldState.set_state("has_wood", false)
			return true

	actor.move_to(actor.position.direction_to(_closest_spot.position), delta)

	return false
