class_name MainMenuSideOptionsButtonsContainer
extends Control


@export var title_label: Label
@export var show_sportsman_profile_button: Button
@export var show_food_plan_workspace_button: Button
@export var show_event_history_button: Button


func _ready() -> void:
	var options_button_group := ButtonGroup.new()
	show_sportsman_profile_button.button_group = options_button_group
	show_food_plan_workspace_button.button_group = options_button_group
	show_event_history_button.button_group = options_button_group
	
	show_sportsman_profile_button.toggled.connect(_open_sportsman_profile)
	show_food_plan_workspace_button.toggled.connect(_open_food_plan_workspace)
	show_event_history_button.toggled.connect(_open_event_history)


func _open_sportsman_profile(is_toggled: bool) -> void:
	if is_toggled:
		title_label.text = "Mostrando\nPerfil do Paciente"
		
	else:
		title_label.text = "Ações Disponíveis\n"


func _open_food_plan_workspace(is_toggled: bool) -> void:
	if is_toggled:
		title_label.text = "Mostrando\nPlanejamento Alimentar"
		
	else:
		title_label.text = "Ações Disponíveis\n"



func _open_event_history(is_toggled: bool) -> void:
	if is_toggled:
		title_label.text = "Mostrando\nEventos Passados"
		
	else:
		title_label.text = "Ações Disponíveis\n"
