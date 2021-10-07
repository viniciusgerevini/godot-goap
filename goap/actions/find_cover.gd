extends GoapAction

class_name FindCoverAction


func get_class(): return "FindCoverAction"


func get_cost() -> int:
  return 1


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {
    "protected": true
  }


func perform(actor, delta) -> bool:
  var closest_cover = _get_closest_cover(actor)

  if closest_cover == null:
    return false

  if closest_cover.position.distance_to(actor.position) < 1:
    return true

  actor.move_to(actor.position.direction_to(closest_cover.position), delta)
  return false


func _get_closest_cover(actor):
  var covers = WorldState.get_elements("cover")
  var closest_cover
  var closest_distance = 10000000

  for cover in covers:
    var distance = actor.position.distance_to(cover.position)
    if  distance < closest_distance:
      closest_distance = distance
      closest_cover = cover

  return closest_cover
