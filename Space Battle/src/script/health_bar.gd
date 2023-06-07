extends VBoxContainer

signal gameOver

@onready var player_Name: = get_node("Label")
@onready var life_bar: = get_node("ProgressBar")

const GREEN_COLOR = "13d523"
const YELLOW_COLOR = "c9cf0b"
const RED_COLOR = "d72a0f"

func setHealthBar(amount) -> void:
	life_bar.max_value = amount
	life_bar.value = amount

func take_damage(amount) -> void:
	life_bar.value -= amount
	PlayerDead()
	update_health_bar_color()

func PlayerDead() -> void:
	if life_bar.value <= 0:
		gameOver.emit()

func PlayerName(player_name) -> void:
	player_Name.text = player_name

func update_health_bar_color() -> void:
	if life_bar.value > (life_bar.max_value * 0.7):
		life_bar.change_color(GREEN_COLOR)
	elif life_bar.value > (life_bar.max_value * 0.3):
		life_bar.change_color(YELLOW_COLOR)
	else:
		life_bar.change_color(RED_COLOR)
	
