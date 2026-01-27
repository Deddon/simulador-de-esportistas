class_name SportsmanSelectionSportsDescription
extends Control


signal sport_selected(sport: Constants.SportsmanAvailableSports)


@export_group("Description")
@export var sports_description_label: Label
@export var sports_button0: Button
@export_multiline var sports_description0: String
@export var sports_button1: Button
@export_multiline var sports_description1: String
@export var sports_button2: Button
@export_multiline var sports_description2: String


func _ready() -> void:
	var sports_description_button_group := ButtonGroup.new()
	sports_button0.button_group = sports_description_button_group
	sports_button0.toggled.connect(_set_sports_description.bind(0))
	sports_button1.button_group = sports_description_button_group
	sports_button1.toggled.connect(_set_sports_description.bind(1))
	sports_button2.button_group = sports_description_button_group
	sports_button2.toggled.connect(_set_sports_description.bind(2))
	
	sports_button0.toggled.emit(true)


func _set_sports_description(is_toggled: bool, button_index: int) -> void:
	if not is_toggled:
		return
	
	match button_index:
		0:
			sports_description_label.text = sports_description0
			sport_selected.emit(Constants.SportsmanAvailableSports.OLYMPIC_WEIGHT_LIFTER)
		1:
			sports_description_label.text = sports_description1
			sport_selected.emit(Constants.SportsmanAvailableSports.LONG_RUNNER)
		2:
			sports_description_label.text = sports_description2
			sport_selected.emit(Constants.SportsmanAvailableSports.FOUR_HUNDRED_METERS_RUNNER)
