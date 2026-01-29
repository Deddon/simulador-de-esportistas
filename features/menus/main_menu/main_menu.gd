class_name MainMenu
extends Control


signal new_diet_set()

@export var skip_welcome: bool = true

@export_group("Components")
@export var side_bar: MainMenuSideBar

@onready var game_watch: MainMenuGameWatch = $GameWatch
@onready var welcome_view: MainMenuWelcomeView = $WelcomeView

var current_sportsman: Sportsman
var current_diet: Diet


func _ready() -> void:
	side_bar.sportsman_change_requested.connect(func():
		print_debug("Sportsman change requested.")
	)
	
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
	
	current_sportsman = preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres")
	current_diet = preload("res://shared/resources/diet/demo_diet.tres")
	
	if not skip_welcome:
		welcome_view.show_welcome(current_sportsman)
	
	side_bar.update(current_sportsman)


func set_current_diet(new_diet: Diet) -> void:
	current_diet = new_diet
	new_diet_set.emit()


func get_current_sportsman() -> Sportsman:
	return current_sportsman


func get_current_diet() -> Diet:
	return current_diet
