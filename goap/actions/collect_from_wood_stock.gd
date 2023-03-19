extends GoapAction

class_name CollectFromWoodStockAction

func get_clazz(): return "CollectFromWoodStockAction"


func is_valid() -> bool:
	return WorldState.get_elements("wood_stock").size() > 0


func get_cost(blackboard) -> int:
	if blackboard.has("position"):
		var closest_tree = WorldState.get_closest_element("wood_stock", blackboard)
		return int(closest_tree.position.distance_to(blackboard.position) / 5)
	return 5


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		"has_wood": true,
	}


func perform(actor, delta) -> bool:
	var closest_stock = WorldState.get_closest_element("wood_stock", actor)

	if closest_stock:
		if closest_stock.position.distance_to(actor.position) < 10:
			closest_stock.queue_free()
			WorldState.set_state("has_wood", true)
			return true
		else:
			actor.move_to(actor.position.direction_to(closest_stock.position), delta)

	return false
