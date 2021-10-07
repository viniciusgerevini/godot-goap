extends GoapAction

class_name BuildFirepitAction

const Firepit = preload("res://scenes/firepit.tscn")


func get_class(): return "BuildFirepitAction"


func get_cost() -> int:
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
  var _closest_spot = _get_closest_firepit_spot(actor)

  if _closest_spot == null:
    return false

  if _closest_spot.position.distance_to(actor.position) < 20:
      var firepit = Firepit.instance()
      actor.get_parent().add_child(firepit)
      firepit.position = _closest_spot.position
      firepit.z_index = _closest_spot.z_index
      return true

  actor.move_to(actor.position.direction_to(_closest_spot.position), delta)

  return false


func _get_closest_firepit_spot(actor):
  var spots = WorldState.get_elements("firepit_spot")
  var closest_firepit_spot
  var closest_distance = 10000000

  for spot in spots:
    var distance = actor.position.distance_to(spot.position)
    if  distance < closest_distance:
      closest_distance = distance
      closest_firepit_spot = spot

  return closest_firepit_spot

