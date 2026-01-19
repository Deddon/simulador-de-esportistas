class_name MainMenu
extends Control


@export var game_watch: MainMenuGameWatch


func _enter_tree() -> void:
	if GameBuffer.get_buffered_sportsman():
		return
	
	# WARNING: TEMPORARY
	var demo_sportsman := Sportsman.new()
	demo_sportsman.name = "Demo Sportsman"
	demo_sportsman.current_sport = Constants.SportsmanAvailableSports.FOUR_HUNDRED_METERS_RUNNER
	demo_sportsman.weight_kg = 70.0
	GameBuffer.add_sportsman(demo_sportsman)
	
	var demo_diet := Diet.new()
	demo_diet.diet_name = "Demo Diet"
	demo_diet.add_food(preload("uid://bax262d14k621"), 100.0)
	demo_diet.add_food(preload("uid://46xp7hl2c3si"), 100.0)
	demo_diet.add_food(preload("uid://cs3wn3lebw5re"), 100.0)
	GameBuffer.add_diet(demo_diet)
	
	await get_tree().create_timer(0.5).timeout


func _ready() -> void:
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
