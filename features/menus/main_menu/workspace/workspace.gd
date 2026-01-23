class_name MainMenuWorkspace
extends Control


@export var main_container: Container
@export var tabs_container: Container


func _ready() -> void:
	_create_tabs_button_group()


func _create_tabs_button_group() -> void:
	var tabs_button_group := ButtonGroup.new()
	
	for tab: MainMenuWorkspaceTab in tabs_container.get_children():
		tab.mouse_detector_button.button_group = tabs_button_group
		tab.tab_selected.connect(_handle_tab_selection.bind(tab))
		tab.tab_desselected.connect(_handle_tab_desselection.bind(tab))


func _handle_tab_selection(_tab_packed_scene: PackedScene, _selected_tab: MainMenuWorkspaceTab) -> void:
	pass


func _handle_tab_desselection(_selected_tab: MainMenuWorkspaceTab) -> void:
	pass
