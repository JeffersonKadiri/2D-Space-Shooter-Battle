extends Area2D
class_name Actor

signal hit

@export var Bullet: PackedScene
@export var bullet_speed: float = 200.0
@export var player_speed: float = 200.0

@onready var _Player_Size: Vector2 = get_node("Sprite").texture.get_size() * scale
@onready var screen_size: = get_viewport_rect().size
@onready var barrel: = get_node("Sprite/Marker2D")
@onready var reload_timer: Timer = get_node("ReloadTimer")
@onready var sound: = get_node("ShotSound")

const MAX_BULLET = 5

var bullet_remaining = MAX_BULLET
var velocity: Vector2 = Vector2.ZERO

func _on_reload_timeout() -> void:
	bullet_remaining = MAX_BULLET

func start_position(pos):
	show()
	position = pos
	$CollisionShape2D.disabled = false

func shoot(pos: Vector2) -> void:
	var bullet_instance = Bullet.instantiate()
	bullet_instance.start(pos, bullet_speed)
	get_parent().add_child(bullet_instance)
	bullet_remaining -= 1

func _update_position(min_dis, max_dis) -> void:
	position += velocity * get_process_delta_time()
	position.x = clamp(position.x, min_dis, max_dis)
	position.y = clamp(position.y, Half_Height(), screen_size.y - Half_Height())

func ship_destroyed() -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

func bullet_Remain():
	if bullet_remaining > 0:
		reload_timer.stop()
		shoot(barrel.global_position)
		sound.play()
		reload_timer.start()

func default_state() -> void:
	if !reload_timer.is_stopped():
		reload_timer.stop()
	bullet_remaining = MAX_BULLET

func can_move(value: bool) -> void:
	set_process(value)

func Half_Height() -> float:
	return _Player_Size.y / 2

func Half_Width() -> float:
	return _Player_Size.x / 2

func get_player_size() -> Vector2:
	return _Player_Size

func _on_area_entered(area):
	hit.emit(area.bullet_strength)
