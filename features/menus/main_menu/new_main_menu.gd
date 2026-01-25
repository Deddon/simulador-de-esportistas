class_name MainMenu
extends Control


@export var skip_welcome: bool = true

@export_group("Components")
@export var side_bar: MainMenuSideBar

@onready var game_watch: MainMenuGameWatch = $GameWatch
@onready var welcome_view: MainMenuWelcomeView = $WelcomeView

var current_sportsman: Sportsman


func _ready() -> void:
	if GameBuffer.get_all_sportsmen().size() > 0:
		print_debug("Sportsman detected, but it was not passed forward.")
		return
	
	var demo_sportsman: Sportsman = preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres")
	
	var demo1_diet := Diet.new()
	demo1_diet.diet_name = "Demo Diet"
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 100.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 90.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 1.0)
	
	demo_sportsman.current_diet = demo1_diet
	
	var demo2_diet := Diet.new()
	
	demo2_diet.add_food(preload("res://shared/resources/foods/carne.tres"), 1.0)
	demo2_diet.add_food(preload("res://shared/resources/foods/carne.tres"), 2.0)
	
	demo_sportsman._submitted_diets_history.append(demo2_diet)
	current_sportsman = demo_sportsman
	
	#game_watch.ticked.connect(func(): game_watch.print_simulated_datetime())
	side_bar.sportsman_change_requested.connect(_change_sportsman)
	
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
	
	if not skip_welcome:
		welcome_view.show_welcome(demo_sportsman)
	
	side_bar.update(demo_sportsman)


func _change_sportsman() -> void:
	print_debug("Sportsman change requested.")
