class_name MainMenuWelcomeView
extends CanvasLayer


@export var welcome_container: Container
@export var start_button: Button
@export var introduction_view: SportsmanIntroductionView


func _ready() -> void:
	hide()
	start_button.pressed.connect(_show_sportsman_introduction)


func show_welcome() -> void:
	get_tree().paused = true
	introduction_view.hide()
	welcome_container.show()
	show()


func _show_sportsman_introduction() -> void:
	welcome_container.hide()
	
	print_debug("Loading default sportsman.")
	var s: Sportsman = preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres")
	introduction_view.update_and_show(s)
	
	await introduction_view.dismissed
	hide()
