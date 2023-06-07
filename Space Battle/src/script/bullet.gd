extends Area2D

var velocity
var bullet_strength: = randi_range(10, 100)

func _on_screen_exited():
	queue_free()

func _on_area_entered(_area):
	queue_free()

func _process(delta):
	position += velocity * delta

func start(_position, speed) -> void:
	position = _position
	velocity = Vector2(speed, 0)
