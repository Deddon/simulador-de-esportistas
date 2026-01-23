class_name MainMenuWorkspace
extends Control


@export var main_container: Container
@export var tabs_container: Container

var instantiated_tabs_scene: Dictionary[int, Control] = {}


func _ready() -> void:
	_create_tabs_button_group()
	_show_visao_geral_at_start()


func _create_tabs_button_group() -> void:
	var tabs_button_group := ButtonGroup.new()
	var tabs_list = tabs_container.get_children() as Array[MainMenuWorkspaceTab]
	
	for tab_index: int in tabs_list.size():
		var current_tab: MainMenuWorkspaceTab = tabs_list[tab_index]
		
		current_tab.mouse_detector_button.button_group = tabs_button_group
		current_tab.tab_selected.connect(_handle_tab_selection.bind(tab_index))
		current_tab.tab_desselected.connect(_handle_tab_desselection.bind(tab_index))


func _show_visao_geral_at_start() -> void:
	instantiated_tabs_scene[0] = %VisaoGeral.current_packed_scene.instantiate()
	main_container.add_child(instantiated_tabs_scene[0])
	instantiated_tabs_scene[0].show()


func _handle_tab_selection(tab_packed_scene: PackedScene, selected_tab: int) -> void:
	if not tab_packed_scene:
		return
	
	for node: Control in main_container.get_children():
		if not (node is Container):
			node.hide()
	
	if not instantiated_tabs_scene.has(selected_tab):
		var tab_scene: Control = tab_packed_scene.instantiate()
		instantiated_tabs_scene[selected_tab] = tab_scene
		
		main_container.add_child(instantiated_tabs_scene[selected_tab])
	
	instantiated_tabs_scene[selected_tab].show()


func _handle_tab_desselection(selected_tab: int) -> void:
	instantiated_tabs_scene[selected_tab].hide()
	instantiated_tabs_scene[0].show()
