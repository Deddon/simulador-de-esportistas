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
	
	await get_tree().create_timer(0.5).timeout


func _ready() -> void:
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
