extends Control

signal player1_dead
signal player2_dead
signal gameState

@onready var scene_tree: = get_tree()
@onready var view_port: = get_viewport()
@onready var health_bar1: = get_node("HealthBar1")
@onready var health_bar2: = get_node("HealthBar2")
@onready var score_1: = get_node("ScoreBoard/Score1")
@onready var score_2: = get_node("ScoreBoard/Score2")
@onready var pause_overlay: = get_node("PauseOverlay")
@onready var message: = get_node("Message")
@onready var wall: = get_node("Wall")
@onready var message_timer: = get_node("MessageTimer")

var player1wins: = 0
var player2wins: = 0

var paused = false

func _ready():
	setPlayersName()

func _on_pause_button_pressed():
	set_paused(true)

func _on_player_1_hit(amount):
	health_bar1.take_damage(amount)

func _on_player_2_hit(amount):
	health_bar2.take_damage(amount)

func _on_Player1_Dead_game_over():
	player2wins += 1
	setMessageDetails("Player 2 Wins")
	player1_dead.emit()

func _on_health_bar_2_game_over():
	player1wins += 1
	setMessageDetails("Player 1 Wins")
	player2_dead.emit()

func _on_message_timer_timeout():
	message.hide()
	wall.show()
	gameState.emit(message.text)

func _on_resume_button_pressed():
	set_paused(false)

func _on_home_button_pressed():
	scene_tree.reload_current_scene()
	set_paused(false)

func  setPlayersName() -> void:
	health_bar1.PlayerName("Player 1")
	health_bar2.PlayerName("Player 2")

func setPlayersHealth(amount) -> void:
	health_bar1.setHealthBar(amount)
	health_bar2.setHealthBar(amount)

func update_bar_colors() -> void:
	health_bar1.update_health_bar_color()
	health_bar2.update_health_bar_color()

func update_players_score() -> void:
	score_1.text = "%s" % player1wins
	score_2.text = "%s" % player2wins

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		set_paused(not paused)
		view_port.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func Display_message() -> void:
	message.show()
	wall.hide()
	message_timer.start()

func setMessageDetails(value: String) -> void:
	message.text = value
	update_players_score()
