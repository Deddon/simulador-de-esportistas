class_name MainMenuSportsmanTab
extends Control


signal tab_selected(tab_sportsman: Sportsman)

@export var sportsman_name_label: Label
@export var click_sensor_button: Button

var _sportsman: Sportsman


func _ready() -> void:
	click_sensor_button.toggled.connect(_handle_tab_seletion)


func update_tab(sportsman: Sportsman) -> void:
	var name_shown_on_tab: String = sportsman.name.strip_edges()
	_sportsman = sportsman
	
	if " " in name_shown_on_tab:
		sportsman_name_label.text = name_shown_on_tab.split(" ")[0]
		return
	
	sportsman_name_label.text = name_shown_on_tab


func _handle_tab_seletion(is_selected: bool) -> void:
	if is_selected:
		tab_selected.emit(_sportsman)
