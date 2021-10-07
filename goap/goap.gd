extends Node

var _action_planner =  GoapActionPlanner.new()

func _ready():
  _action_planner.set_actions([
    BuildFirepitAction.new(),
    ChopTreeAction.new(),
    CollectFromWoodStockAction.new(),
    CalmDownAction.new(),
    FindCoverAction.new(),
  ])


func get_action_planner() -> GoapActionPlanner:
  return _action_planner
