class_name SportsEvent
extends Resource


@export var name: String
@export var event_icon: CompressedTexture2D
@export var duration_days: float = 1.0
@export var target_sport: Constants.SportsmanAvailableSports = Constants.SportsmanAvailableSports.NULL
@export_multiline var description: String
@export var _start_simulated_seconds: float = -1.0


## Currently, only useful to show event finish date visually.
func set_start_timestamp(start_simulated_time: float) -> void:
	_start_simulated_seconds = start_simulated_time


func get_event_start_seconds() -> float:
	return _start_simulated_seconds
