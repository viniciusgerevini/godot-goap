extends GoapGoal

class_name RelaxGoal

func get_clazz(): return "RelaxGoal"

# relax will always be available
func is_valid() -> bool:
	return true


# relax has lower priority compared to other goals
func priority() -> int:
	return 0
