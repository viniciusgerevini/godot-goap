#
# Planner. Goap's heart.
#
extends Node

class_name GoapActionPlanner

var _actions: Array


#
# set actions available for planning.
# this can be changed in runtime for more dynamic options.
#
func set_actions(actions: Array):
	_actions = actions


#
# Receives a Goal and an optional blackboard.
# Returns a list of actions to be executed.
#
func get_plan(goal: GoapGoal, blackboard = {}) -> Array:
	print("Goal: %s" % goal.get_clazz())
	WorldState.console_message("Goal: %s" % goal.get_clazz())
	var desired_state = goal.get_desired_state().duplicate()

	if desired_state.is_empty():
		return []

	return _find_best_plan(goal, desired_state, blackboard)



func _find_best_plan(goal, desired_state, blackboard):
  # goal is set as root action. It does feel weird
  # but the code is simpler this way.
	var root = {
		"action": goal,
		"state": desired_state,
		"children": []
	}

  # build plans will populate root with children.
  # In case it doesn't find a valid path, it will return false.
	if _build_plans(root, blackboard.duplicate()):
		var plans = _transform_tree_into_array(root, blackboard)
		return _get_cheapest_plan(plans)

	return []


#
# Compares plan's cost and returns
# actions included in the cheapest one.
#
func _get_cheapest_plan(plans):
	var best_plan
	for p in plans:
		_print_plan(p)
		if best_plan == null or p.cost < best_plan.cost:
			best_plan = p
	return best_plan.actions


#
# Builds graph with actions. Only includes valid plans (plans
# that achieve the goal).
#
# Returns true if the path has a solution.
#
# This function uses recursion to build the graph. This is
# necessary because any new action included in the graph may
# add pre-conditions to the desired state that can be satisfied
# by previously considered actions, meaning, on every step we
# need to iterate from the beginning to find all solutions.
#
# Be aware that for simplicity, the current implementation is not protected from
# circular dependencies. This is easy to implement though.
#
func _build_plans(step, blackboard):
	var has_followup = false

  # each node in the graph has it's own desired state.
	var state = step.state.duplicate()
  # checks if the blackboard contains data that can
  # satisfy the current state.
	for s in step.state:
		if state[s] == blackboard.get(s):
			state.erase(s)

  # if the state is empty, it means this branch already
  # found the solution, so it doesn't need to look for
  # more actions
	if state.is_empty():
		return true

	for action in _actions:
		if not action.is_valid():
			continue

		var should_use_action = false
		var effects = action.get_effects()
		var desired_state = state.duplicate()

	# check if action should be used, i.e. it
	# satisfies at least one condition from the
	# desired state
		for s in desired_state:
			if desired_state[s] == effects.get(s):
				desired_state.erase(s)
				should_use_action = true

		if should_use_action:
			# adds actions pre-conditions to the desired state
			var preconditions = action.get_preconditions()
			for p in preconditions:
				desired_state[p] = preconditions[p]

			var s = {
				"action": action,
				"state": desired_state,
				"children": []
				}

			# if desired state is empty, it means this action
			# can be included in the graph.
			# if it's not empty, _build_plans is called again (recursively) so
			# it can try to find actions to satisfy this current state. In case
			# it can't find anything, this action won't be included in the graph.
			if desired_state.is_empty() or _build_plans(s, blackboard.duplicate()):
				step.children.push_back(s)
				has_followup = true

	return has_followup


#
# Transforms graph with actions into list of actions and calculates
# the cost by summing actions' cost
#
# Returns list of plans.
#
func _transform_tree_into_array(p, blackboard):
	var plans = []

	if p.children.size() == 0:
		plans.push_back({ "actions": [p.action], "cost": p.action.get_cost(blackboard) })
		return plans

	for c in p.children:
		for child_plan in _transform_tree_into_array(c, blackboard):
			if p.action.has_method("get_cost"):
				child_plan.actions.push_back(p.action)
				child_plan.cost += p.action.get_cost(blackboard)
			plans.push_back(child_plan)
	return plans


#
# Prints plan. Used for Debugging only.
#
func _print_plan(plan):
	var actions = []
	for a in plan.actions:
		actions.push_back(a.get_clazz())
	print({"cost": plan.cost, "actions": actions})
	WorldState.console_message({"cost": plan.cost, "actions": actions})
