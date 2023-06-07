extends Actor

func _init():
	bullet_speed = -500.0
	print(bullet_speed)
	Bullet = load("res://src/scenes/Objects/bullet.tscn")
	_Player_Size = get_node("Sprite").texture.get_size() * scale
	screen_size = get_viewport_rect().size
	barrel = get_node("Sprite/Marker2D")
	reload_timer = get_node("ReloadTimer")
	sound = get_node("ShotSound")
	var childCount = get_child_count()
	if childCount > 0:
		var lastChild = get_child(childCount - 1)
		lastChild.queue_free()

func _process(_delta):
	PlayerInput()
	_update_position(screen_size.x/2 + Half_Width(), screen_size.x - Half_Width())

func PlayerInput() -> void:
	var direction = Input.get_vector("player2_left", "player2_right", "player2_up", "player2_down")
	velocity = direction * player_speed
	if Input.is_action_just_pressed("player2_shoot"):
		bullet_Remain()
