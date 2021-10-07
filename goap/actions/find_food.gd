extends GoapAction

class_name FindFoodAction


func get_class(): return "FindFoodAction"


func get_cost() -> int:
  return 1


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {
    "is_hungry": false
  }


func perform(actor, delta) -> bool:
  var closest_food = _get_closest_food(actor)

  if closest_food == null:
    return false

  if closest_food.position.distance_to(actor.position) < 5:
    WorldState.set_state("hunger", WorldState.get_state("hunger") - closest_food.nutrition)
    closest_food.queue_free()
    return true

  actor.move_to(actor.position.direction_to(closest_food.position), delta)
  return false


func _get_closest_food(actor):
  var food = WorldState.get_elements("food")
  var closest_food
  var closest_distance = 10000000

  for f in food:
    var distance = actor.position.distance_to(f.position)
    if  distance < closest_distance:
      closest_distance = distance
      closest_food = f

  return closest_food

