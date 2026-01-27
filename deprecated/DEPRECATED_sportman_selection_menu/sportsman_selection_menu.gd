class_name SportsmanSelectionMenu
extends Control


@export var sports_description: SportsmanSelectionSportsDescription
@export var sportsman_profile: SportsmanSelectionSportsmanProfile
@export var main_menu_packed_scene: PackedScene

@onready var _sportsman: Sportsman = Sportsman.new()
@onready var submit_sportsman_button: Button = get_tree().get_first_node_in_group("submit_sportsman_button")
@onready var sportsman_name_line_edit: LineEdit = get_tree().get_first_node_in_group("sportsman_name_line_edit")


func _ready() -> void:
	sports_description.sport_selected.connect(_update_selected_sport)
	sportsman_profile.weight_selected.connect(_update_weight)
	
	if sportsman_name_line_edit:
		sportsman_name_line_edit.text_submitted.connect(_update_sportsman_name)
	
	if submit_sportsman_button:
		submit_sportsman_button.pressed.connect(_move_to_main_menu)


func _update_selected_sport(selected_sport: Constants.SportsmanAvailableSports) -> void:
	_sportsman.current_sport = selected_sport


func _update_weight(new_weight_kg: float) -> void:
	_sportsman.weight_kg = new_weight_kg


func _update_sportsman_name(new_name: String) -> void:
	_sportsman.name = new_name


func _move_to_main_menu() -> void:
	GameBuffer.add_sportsman(_sportsman)
	print("MOVING TO MAIN MENU")
	
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(main_menu_packed_scene)
