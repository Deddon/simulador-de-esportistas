class_name MainMenuSportsmanTab
extends Control


@export var sportsman_name_label: Label
@export var click_sensor_button: Button
@export var hover_color_rect: ColorRect

var _sportsman: Sportsman

@onready var sportsman_profile: MainMenuSportsmanProfile = get_tree().get_first_node_in_group("sportsman_profile")


func _ready() -> void:
	click_sensor_button.toggled.connect(_handle_tab_seletion)
	click_sensor_button.mouse_entered.connect(func():
		hover_color_rect.show()
	)
	click_sensor_button.mouse_exited.connect(func():
		hover_color_rect.hide()
	)


func update_tab(sportsman: Sportsman) -> void:
	var name_shown_on_tab: String = sportsman.name.strip_edges()
	_sportsman = sportsman
	
	if " " in name_shown_on_tab:
		sportsman_name_label.text = name_shown_on_tab.split(" ")[0]
		return
	
	sportsman_name_label.text = name_shown_on_tab


func _handle_tab_seletion(is_selected: bool) -> void:
	if is_selected and sportsman_profile:
		sportsman_profile.update_sportsman_stats(_sportsman)
