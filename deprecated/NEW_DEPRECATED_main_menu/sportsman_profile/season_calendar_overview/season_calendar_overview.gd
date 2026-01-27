class_name SportsmanProfileSeasonCalendarOverview
extends Control


@export var label: Label

@onready var game_watch: MainMenuGameWatch = get_tree().get_first_node_in_group("game_watch")

var _sportsman: Sportsman


func _ready() -> void:
	if not game_watch.has_date_been_set:
		await game_watch.initialized
	
	var demo_event := SportsEvent.new()
	demo_event.name = "Demo Event1"
	demo_event.duration_days = 0.001
	demo_event.set_start_timestamp(game_watch.get_now_simulated_seconds())
	
	#var event_start_datetime = game_watch.get_simulated_datetime(demo_event.get_event_start_seconds())
	#print_debug("Evento começou dia %s: " % event_start_datetime.day, event_start_datetime.hour, ":", event_start_datetime.minute,
	#"\nCom duração em dias: ", demo_event.duration_days)
	
	var demo_event_result := SportsEventResult.new()
	demo_event_result.event = demo_event
	
	_sportsman = Sportsman.new()
	_sportsman.name = "Demo Sportsman"
	_sportsman.add_finished_event_result(demo_event_result)
	
	#event_start_datetime = game_watch.get_event_finish_datetime(demo_event)
	#print_debug("\nE terminará dia %s: " % event_start_datetime.day, event_start_datetime.hour, ":", event_start_datetime.minute,)
	
	var event_finish_datetime: Dictionary = game_watch.get_event_finish_datetime(demo_event)
	
	label.text = str(
		demo_event_result.event.name, "\n",
		"Termina: %d/%d as %d:%d" % [
			event_finish_datetime.day,
			event_finish_datetime.month,
			event_finish_datetime.hour,
			event_finish_datetime.minute
		], "\n",
		"Terminou? ", game_watch.is_event_over(demo_event)
	)
