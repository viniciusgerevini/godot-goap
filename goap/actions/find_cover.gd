extends GoapAction

class_name FindCoverAction


func get_clazz(): return "FindCoverAction"


func get_cost(_blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		"protected": true
	}


func perform(actor, delta) -> bool:
	var closest_cover = WorldState.get_closest_element("cover", actor)

	if closest_cover == null:
		return false

	if closest_cover.position.distance_to(actor.position) < 1:
		return true

	actor.move_to(actor.position.direction_to(closest_cover.position), delta)
	return false
