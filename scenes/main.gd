extends Node2D


onready var _hunger_field = $HUD/VBoxContainer/MarginContainer/HBoxContainer/hunger


func _on_hanger_timer_timeout():
  _hunger_field.value = WorldState.get_state("hunger", 0)
  if _hunger_field.value < 100:
    _hunger_field.value += 2

  WorldState.set_state("hunger", _hunger_field.value)


func _on_reload_pressed():
  WorldState.clear_state()
  # warning-ignore:return_value_discarded
  self.get_tree().reload_current_scene()
