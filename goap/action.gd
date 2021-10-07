extends Node

class_name GoapAction

func is_valid() -> bool:
  return true


func get_cost(_blackboard) -> int:
  return 1000


func get_preconditions() -> Dictionary:
  return {}


func get_effects() -> Dictionary:
  return {}


func perform(actor, delta) -> bool:
  return false
