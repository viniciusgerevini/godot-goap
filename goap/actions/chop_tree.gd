extends GoapAction

class_name ChopTreeAction

func get_class(): return "ChopTreeAction"


func is_valid() -> bool:
  return WorldState.get_elements("tree").size() > 0


func get_cost() -> int:
  # TODO define cost based on tree distance
  return 3


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {
    "has_wood": true
  }


func perform(actor, delta) -> bool:
  var _closest_tree = _get_closest_tree(actor)

  if _closest_tree:
    if _closest_tree.position.distance_to(actor.position) < 10:
        if actor.chop_tree(_closest_tree):
          WorldState.set_state("has_wood", true)
          return true
        return false
    else:
      actor.move_to(actor.position.direction_to(_closest_tree.position), delta)

  return false


func _get_closest_tree(actor):
  var trees = WorldState.get_elements("tree")
  var closest_tree
  var closest_distance = 10000000

  for tree in trees:
    var distance = actor.position.distance_to(tree.position)
    if  distance < closest_distance:
      closest_distance = distance
      closest_tree = tree

  return closest_tree
