extends GoapGoal

class_name KeepFedGoal

func get_class(): return "KeepFedGoal"

# only valid if player is hungry
func is_valid() -> bool:
  return WorldState.get_state("is_hungry")


func priority() -> int:
  return 2


func get_desired_state() -> Dictionary:
  return {
    "is_hungry": false
  }
