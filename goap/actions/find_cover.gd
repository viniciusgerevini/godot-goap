extends GoapAction

class_name FindCoverAction


func get_class(): return "FindCoverAction"


func get_cost() -> int:
  return 1


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {}


func perform(actor, delta) -> bool:
  return false
