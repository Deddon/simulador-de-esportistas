class_name MainMenuSportsmanProfile
extends Control


@export var no_sportsman_selected_container: Container
@export var sportsman_selectecd_container: Container
@export var side_bar_options: SportsmanProfileOptionsButtonContainer

var current_sportsman: Sportsman


func _ready() -> void:
	sportsman_selectecd_container.hide()
	no_sportsman_selected_container.show()


func update_sportsman_stats(sportsman: Sportsman) -> void:
	current_sportsman = sportsman
	
	get_viewport().gui_release_focus()
	side_bar_options.reset_buttons()
	
	print_debug("Now show %s stats." % current_sportsman.name)
	no_sportsman_selected_container.hide()
	sportsman_selectecd_container.show()
