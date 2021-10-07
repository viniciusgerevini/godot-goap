extends KinematicBody2D

var is_moving = false

func _ready():
  var agent = GoapAgent.new()
  agent.init(self, [
    HasFirepitGoal.new(),
    KeepFedGoal.new(),
    CalmDownGoal.new(),
    RelaxGoal.new()
  ])

  add_child(agent)


func _process(delta):
  $labels/afraid_label.visible = WorldState.get_state("is_frightened", false)
  $labels/hungry_label.visible = WorldState.get_state("hunger", 0) >= 50

  if not is_moving:
    $body.play("idle")
  is_moving = false


func move_to(direction, delta):
  is_moving = true
  $body.play("run")
  if direction.x > 0:
    turn_right()
  else:
    turn_left()

  move_and_collide(direction * delta * 100)



func turn_right():
  if not $body.flip_h:
    return

  $body.flip_h = false


func turn_left():
  if $body.flip_h:
    return

  $body.flip_h = true


func chop_tree(tree):
  return tree.chop()


func calm_down():
  if WorldState.get_state("is_frightened") == false:
    return true

  if $calm_down_timer.is_stopped():
    $calm_down_timer.start()

  return false


func _on_detection_radius_body_entered(body):
  if body.is_in_group("troll"):
    WorldState.set_state("is_frightened", true)


func _on_calm_down_timer_timeout():
  WorldState.set_state("is_frightened", false)
