class_name MainMenuHeader
extends Control


@export var sportsman_data_label: Label
@export var datetime_info_label: Label

@onready var _sportsman: Sportsman = GameBuffer.get_buffered_sportsman()


func _ready() -> void:
	sportsman_data_label.text = str(
		_sportsman.name, "\n",
		Constants.SportsmanAvailableSports.keys()[_sportsman.current_sport], "\n\n",
		_sportsman.weight_kg, " kg"
	)
