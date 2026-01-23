extends Control


@onready var game_watch: MainMenuGameWatch = $GameWatch


func _ready() -> void:
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
	game_watch.ticked.connect(func(): game_watch.print_simulated_datetime())
