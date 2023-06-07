extends CanvasLayer

signal startgame

@onready var versus = get_node("HBoxContainer")
@onready var computer_button = versus.get_node("ComputerButton")
@onready var human_button = versus.get_node("HumanButton")

func _on_start_game():
	hide()
	$MainMusic.stop()
	startgame.emit(button_pressed())

func _on_computer_button_pressed():
	changeComputerButtonState(true)
	changeHumanButtonState(false)

func _on_human_button_pressed():
	changeComputerButtonState(false)
	changeHumanButtonState(true)

func button_pressed() -> bool:
	return true if computer_button.is_pressed() else false

func changeHumanButtonState(value: bool) -> void:
	human_button.set_toggle_mode(value)
	human_button.set_pressed(value)

func changeComputerButtonState(value: bool) -> void:
	computer_button.set_toggle_mode(value)
	computer_button.set_pressed(value)
