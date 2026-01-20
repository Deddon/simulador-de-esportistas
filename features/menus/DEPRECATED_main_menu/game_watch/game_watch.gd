class_name MainMenuGameWatch
extends Node


signal event_finished(target_event: SportsEvent)
signal ticked()

const MINUTE := 60
const HOUR := 3600
const DAY := 86400
const WEEK := 604800
const UTC_MINUS_3 := -10800

const MONTH_NAMES: Array[String] = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
const WEEKDAYS_NAMES: Array[String] = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

@export var simulated_time_increase_seconds: float = 1200.0

var _start_date: float = 0.0
var _ticks_since_start: int = 0
var has_date_been_set: bool = false

var running_event: SportsEvent
var event_end_remaining_ticks: int = -1

@onready var ticks_timer: Timer = %TicksTimer


func _ready() -> void:
	ticks_timer.wait_time = 1.0 / Constants.GAME_TICKS_PER_SECOND
	ticks_timer.timeout.connect(_on_game_watch_tick)


#func set_start_datetime(seconds_offset: float = 0.0) -> void:
	#_start_date = (Time.get_unix_time_from_system() + UTC_MINUS_3) + seconds_offset


func set_start_datetime_at_business_hour() -> void:
	var current_unix_time: float = Time.get_unix_time_from_system() + UTC_MINUS_3
	var current_datetime: Dictionary = Time.get_datetime_dict_from_unix_time(int(current_unix_time))
	
	if current_datetime.hour > 9:
		current_unix_time -= HOUR * (current_datetime.hour - 9)
	elif current_datetime.hour < 9:
		current_unix_time += HOUR * (9 - current_datetime.hour)
	
	if current_datetime.minute > 30:
		current_unix_time -= MINUTE * (current_datetime.minute - 30)
	elif current_datetime.hour < 30:
		current_unix_time += MINUTE * (30 - current_datetime.minute)
	
	_start_date = current_unix_time
	has_date_been_set = true


func start() -> void:
	if has_date_been_set:
		ticks_timer.start()
		_ticks_since_start = 0
	
	else:
		push_error("No start date set.")


func time_event(target_event: SportsEvent) -> void:
	if running_event:
		push_warning("Timing %s but event %s was running." % [running_event.name, target_event.name])
	
	var event_duration_on_ticks: float = (DAY / simulated_time_increase_seconds) * target_event.duration_days
	var ticks_when_event_finished: float = _ticks_since_start + event_duration_on_ticks
	
	running_event = target_event
	event_end_remaining_ticks = int(ticks_when_event_finished)


func get_simulated_datetime() -> Dictionary:
	var simulated_time_seconds = _start_date + (_ticks_since_start * simulated_time_increase_seconds)
	var datetime_dict: Dictionary = Time.get_datetime_dict_from_unix_time(simulated_time_seconds)
	
	datetime_dict["weekday_string"] = WEEKDAYS_NAMES[datetime_dict.weekday]
	datetime_dict["month_string"] = MONTH_NAMES[datetime_dict.month - 1]
	
	return datetime_dict


func get_event_finish_datetime(target_event: SportsEvent) -> Dictionary:
	var event_duration_on_ticks: float = (DAY / simulated_time_increase_seconds) * target_event.duration_days
	var ticks_when_event_finished: float = _ticks_since_start + event_duration_on_ticks
	
	var datetime_dict: Dictionary = Time.get_datetime_dict_from_unix_time(int(
		_start_date + (ticks_when_event_finished * simulated_time_increase_seconds)
	))
	
	datetime_dict["weekday_string"] = WEEKDAYS_NAMES[datetime_dict.weekday]
	datetime_dict["month_string"] = MONTH_NAMES[datetime_dict.month - 1]
	
	return datetime_dict


func _on_game_watch_tick() -> void:
	_ticks_since_start += 1
	ticked.emit()
	
	if not running_event:
		return
	
	if event_end_remaining_ticks >= 0:
		print_debug("running this")
		event_end_remaining_ticks -= 1
	
	else:
		event_finished.emit(running_event)
		running_event = null
