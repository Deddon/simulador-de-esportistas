extends Control


@export var sportsman_tab1: MainMenuSportsmanTab
@export var sportsman_tab2: MainMenuSportsmanTab
#@export var sportsman_tab3: MainMenuSportsmanTab

@onready var game_watch: MainMenuGameWatch = get_tree().get_first_node_in_group("game_watch")


func _ready() -> void:
	#game_watch.ticked.connect(func(): print("Game Menu: tick."); game_watch.print_simulated_datetime())
	game_watch.event_finished.connect(_handle_event_finished)
	game_watch.set_start_datetime_at_business_hour()
	game_watch.start()
	
	sportsman_tab1.update_tab(preload("res://shared/resources/sportsman/carlos_olympic_weight_lifter.tres"))
	sportsman_tab2.update_tab(preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres"))


func _handle_event_finished(finished_event: SportsEvent) -> void:
	print_debug("Evento: ", finished_event.name, " terminou.")
