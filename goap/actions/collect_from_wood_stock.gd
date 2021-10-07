extends GoapAction

class_name CollectFromWoodStockAction

func get_class(): return "CollectFromWoodStockAction"


func is_valid() -> bool:
  return WorldState.get_elements("wood_stock").size() > 0


func get_cost() -> int:
  return 5


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {
    "has_wood": true,
  }


func perform(actor, delta) -> bool:
  var closest_stock = _get_closest_woodstock(actor)

  if closest_stock:
    if closest_stock.position.distance_to(actor.position) < 10:
      closest_stock.queue_free()
      WorldState.set_state("has_wood", true)
      return true
    else:
      actor.move_to(actor.position.direction_to(closest_stock.position), delta)

  return false


func _get_closest_woodstock(actor):
  var stocks = WorldState.get_elements("wood_stock")
  var closest_stock
  var closest_distance = 10000000

  for stock in stocks:
    var distance = actor.position.distance_to(stock.position)
    if  distance < closest_distance:
      closest_distance = distance
      closest_stock = stock

  return closest_stock

