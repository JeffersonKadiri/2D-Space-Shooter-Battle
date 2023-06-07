extends Node2D

@onready var player1: Actor = get_node("Player1")
@onready var player2: Actor = get_node("Player2")
@onready var interface: = get_node("UserInterface")
@onready var explosion: = get_node("Explosion")
@onready var Music: = get_node("Background")
@onready var player1_start_pos: = get_node("Position1")
@onready var player2_start_pos: = get_node("Position2")

const READY_TEXT = "Get Ready"

func _ready():
	randomize()
	Reset_Game_State()

func _on_Ship_Exploded_finished(_anim_name):
	interface.Display_message()

func start_game_button_pressed(computer: bool):
	if not computer:
		player2.set_script(load("res://src/script/Player2.gd"))
	Get_Ready()

func _on_game_state(value):
	if value == READY_TEXT:
		SetGameElements(true)
	else:
		ResetGame()

func _on_player_1_dead():
	player1.ship_destroyed()
	GameOverPlay(player1.position)

func _on_player_2_dead():
	player2.ship_destroyed()
	GameOverPlay(player2.position)

func ResetGame():
	Reset_Game_State()
	Get_Ready()

func  GameOverPlay(location: Vector2) -> void:
	SetGameElements(false)
	get_tree().call_group("bullets", "queue_free")
	explosion.position = location
	explosion.get_node("AnimationPlayer").play("explode")

func Reset_Game_State() -> void:
	SetGameElements(false)
	interface.setPlayersHealth(randi_range(1000, 3000))
	interface.update_bar_colors()
	SetPlayersPosition()
	SetPlayersBullet()

func Get_Ready() -> void:
	interface.set_paused(false)
	interface.setMessageDetails(READY_TEXT)
	interface.Display_message()

func players_move(value: bool) -> void:
	player1.can_move(value)
	player2.can_move(value)

func SetPlayersPosition() -> void:
	player1.start_position(player1_start_pos.position)
	player2.start_position(player2_start_pos.position)

func SetGameElements(value: bool) -> void:
	players_move(value)
	Music.playing = value

func SetPlayersBullet() -> void:
	player1.default_state()
	player2.default_state()
