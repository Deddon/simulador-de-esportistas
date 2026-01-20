class_name SportsmanProfileOptionsButtonContainer
extends Control


@export var food_plan_buton: Button
@export var season_calendar_button: Button
@export var anamnesis_button: Button
@export var past_results_button: Button


func _ready() -> void:
	var options_button_group := ButtonGroup.new()
	food_plan_buton.button_group = options_button_group
	season_calendar_button.button_group = options_button_group
	anamnesis_button.button_group = options_button_group
	past_results_button.button_group = options_button_group


func reset_buttons() -> void:
	food_plan_buton.button_pressed = false
	season_calendar_button.button_pressed = false
	anamnesis_button.button_pressed = false
	past_results_button.button_pressed = false
