class_name MainMenuHeader
extends Control


@export var sportsman_data_label: Label
@export var datetime_info_label: Label

@onready var _sportsman: Sportsman = GameBuffer.get_buffered_sportsman()
@onready var game_watch: MainMenuGameWatch = get_tree().get_first_node_in_group("game_watch")


func _ready() -> void:
	sportsman_data_label.text = str(
		_sportsman.name, "\n",
		Constants.SportsmanAvailableSports.keys()[_sportsman.current_sport], "\n\n",
		_sportsman.weight_kg, " kg"
	)
	
	if game_watch:
		game_watch.ticked.connect(_update_datetime)
	
	_update_datetime()


func _update_datetime() -> void:
	var datetime_dict: Dictionary = game_watch.get_simulated_datetime()
	
	datetime_info_label.text = str(
		datetime_dict.month_string, "\n",
		datetime_dict.day, " / ", datetime_dict.weekday_string, "\n",
		datetime_dict.hour, ":", datetime_dict.minute
	)
