class_name MainMenuSideBar
extends Control


@export var sportsman_name_label: Label
@export var sportsman_current_sport_label: Label
@export var season_era_label: Label
@export var season_week_label: Label
@export var nutritionist_name_label: Label
@export var nutritionist_crn_label: Label
@export var game_state_node: Control

var _sportsman: Sportsman

@onready var game_watch: MainMenuGameWatch = get_tree().get_first_node_in_group("game_watch")


func _ready() -> void:
	game_state_node.modulate.a = float(get_tree().paused)
	_fill_nutritionist()
	
	if not game_watch.has_date_been_set:
		await game_watch.initialized
	
	_update_season_week()
	game_watch.ticked.connect(_update_season_week)


func _process(_delta: float) -> void:
	var pause_state: bool = get_tree().paused
	game_state_node.modulate.a = float(pause_state)
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not pause_state


func update(sportsman: Sportsman) -> void:
	_sportsman = sportsman
	sportsman_name_label.text = str("Atleta\n", _sportsman.name)
	sportsman_current_sport_label.text = Constants.get_sport_name(_sportsman)


func _fill_nutritionist() -> void:
	nutritionist_name_label.text = "Nutricionista\nDaniela Navarro"
	nutritionist_crn_label.text = "84562-3"


func _update_season_week() -> void:
	var weeks_since_start: int = int(floorf(game_watch.get_now_simulated_weeks()))
	season_week_label.text = str("Semana ", weeks_since_start + 1)
