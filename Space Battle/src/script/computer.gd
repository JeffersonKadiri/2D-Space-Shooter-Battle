extends Actor

enum {
	IDLE,
	NEW_DIRECTION,
	MOVE,
}

var state = IDLE
var move_timer: Timer = Timer.new()

func _ready():
	move_timer.autostart = true
	move_timer.wait_time = 0.5
	add_child(move_timer)
	move_timer.connect("timeout", move_timer_timeout)

func move_timer_timeout():
	move_timer.wait_time = choose([0.4, 0.5, 0.7, 1])
	state = choose([IDLE, NEW_DIRECTION, MOVE])

func _process(_delta):
	match state:
		IDLE:
			bullet_Remain()
		NEW_DIRECTION:
			velocity = choose([Vector2.UP, Vector2.DOWN]) * player_speed
		MOVE:
			_update_position(screen_size.x/2 + Half_Width(), screen_size.x - Half_Width())

func choose(path: Array):
	path.shuffle()
	return path.front()

func _on_script_changed():
	print("Script was been changed")
