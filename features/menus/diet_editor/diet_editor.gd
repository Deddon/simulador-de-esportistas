class_name DietEditor
extends Control


signal diet_submitted(diet: Diet)

@export var foods_in_diet_container: DietEditorFoodsInDietContainer
@export var diet_stats_container: DietEditorDietStats

@export var clear_diet_button: Button
@export var submit_diet_button: Button

var current_diet: Diet
var current_sportsman: Sportsman

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")


func _ready() -> void:
	get_tree().paused = true
	hide()
	
	clear_diet_button.pressed.connect(clear_diet)
	submit_diet_button.pressed.connect(_submit_diet)
	
	current_diet = main_menu.get_current_diet()
	current_sportsman = main_menu.get_current_sportsman()


## Called outside of it.
func update_diet(diet: Diet, sportsman: Sportsman) -> void:
	current_diet = diet
	current_sportsman = sportsman
	
	foods_in_diet_container.update_slots(current_diet)
	diet_stats_container.update_stats(current_diet, current_sportsman)
	
	show()


func clear_diet() -> void:
	current_diet = Diet.new()
	current_diet.diet_name = "New Diet from Editor"
	
	foods_in_diet_container.update_slots(current_diet)
	diet_stats_container.reset_diet()
	
	main_menu.set_current_diet(current_diet)
	foods_in_diet_container.update_slots(current_diet)
	
	#return current_diet


func get_current_diet() -> Diet:
	return current_diet


func _submit_diet() -> void:
	if not current_diet:
		printerr("No diet to submit.")
		return
	
	diet_submitted.emit(current_diet)
	#get_tree().paused = false
