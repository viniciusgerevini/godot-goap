extends Node2D

func _process(_delta):
	$label.text = str(ceil($timer.time_left))

func _on_timer_timeout():
	queue_free()
