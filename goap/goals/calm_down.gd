extends GoapGoal

class_name CalmDownGoal

func get_class(): return "CalmDownGoal"

func is_valid() -> bool:
  return WorldState.get_state("is_frightened")


func priority() -> int:
  return 10


func get_desired_state() -> Dictionary:
  return {
    "is_frightened": false
  }
