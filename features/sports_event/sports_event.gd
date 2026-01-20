class_name SportsEvent
extends Resource


@export var name: String
@export var event_icon: CompressedTexture2D
@export var duration_days: float = 1.0
@export var target_sport: Constants.SportsmanAvailableSports = Constants.SportsmanAvailableSports.NULL
@export_multiline var description: String
