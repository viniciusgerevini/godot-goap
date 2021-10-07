extends StaticBody2D


var _hp = 3


func chop():
  _hp -= 1
  if _hp == 0:
    queue_free()
    return true
  return false
