extends GoapGoal

class_name KeepFedGoal

func get_class(): return "KeepFedGoal"

# only valid if player is hungry
func is_valid() -> bool:
  return WorldState.get_state("hunger", 0)  > 50 and WorldState.get_elements("food").size() > 0


func priority() -> int:
  return 1 if WorldState.get_state("hunger", 0) < 75 else 2


func get_desired_state() -> Dictionary:
  return {
    "is_hungry": false
  }
