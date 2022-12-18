extends StaticBody2D


var _hp = 3


func chop():
	if not $chop_cooldown.is_stopped():
		return false

	_hp -= 1
	if _hp == 0:
		queue_free()
		return true
	$chop_cooldown.start()
	return false
