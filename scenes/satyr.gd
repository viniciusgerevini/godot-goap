extends KinematicBody2D

var is_moving = false
var is_attacking = false

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

  if is_attacking:
    $body.play("attack")
  elif is_moving:
    is_moving = false
  else:
    $body.play("idle")



func move_to(direction, delta):
  is_moving = true
  is_attacking = false
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
  var is_finished = tree.chop()
  is_attacking = not is_finished
  return is_finished


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
