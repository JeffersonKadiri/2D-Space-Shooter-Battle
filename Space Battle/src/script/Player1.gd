extends Actor

func _process(_delta):
	PlayerInput()
	_update_position(Half_Width(), screen_size.x/2 - Half_Width())

func PlayerInput() -> void:
	var direction = Input.get_vector("player1_left", "player1_right", "player1_up", "player1_down")
	velocity = direction * player_speed
	if Input.is_action_just_pressed("player1_shoot"):
		bullet_Remain()
