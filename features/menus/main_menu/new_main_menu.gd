class_name MainMenu
extends Control


@export var skip_welcome: bool = true

@export_group("Components")
@export var side_bar: MainMenuSideBar

@onready var game_watch: MainMenuGameWatch = $GameWatch
@onready var welcome_view: MainMenuWelcomeView = $WelcomeView


func _ready() -> void:
	var demo_sportsman: Sportsman = preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres")
	
	game_watch.ticked.connect(func(): game_watch.print_simulated_datetime())
	side_bar.sportsman_change_requested.connect(_change_sportsman)
	
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
	
	if not skip_welcome:
		welcome_view.show_welcome(demo_sportsman)
	
	side_bar.update(demo_sportsman)


func _change_sportsman() -> void:
	print_debug("Sportsman change requested.")
