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
  $RayCast2D.cast_to *= -1


func turn_left():
  if $body.flip_h:
    return

  $body.flip_h = true
  $RayCast2D.cast_to *= -1


func chop_tree(tree):
  return tree.chop()
