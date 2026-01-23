@tool
class_name MainMenuWorkspaceTab
extends Control


signal tab_selected(current_scene: PackedScene)
signal tab_desselected()


@export var tab_name: String = "Tab":
	set(new_tab_name):
		if not new_tab_name.is_empty():
			tab_name = new_tab_name
		else:
			tab_name = "Tab"
		
		mouse_detector_button.text = tab_name

@export var current_packed_scene: PackedScene
@export var mouse_detector_button: Button


func _ready() -> void:
	mouse_detector_button.toggled.connect(_handle_tab_selection)


func _handle_tab_selection(is_toggled: bool) -> void:
	if is_toggled:
		tab_selected.emit(current_packed_scene)
	else:
		tab_desselected.emit()
