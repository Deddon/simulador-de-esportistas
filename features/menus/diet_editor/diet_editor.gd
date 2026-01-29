class_name DietEditor
extends Control


signal diet_submitted(diet: Diet)

@export var foods_in_diet_container: DietEditorFoodsInDietContainer
@export var diet_stats_container: DietEditorDietStats
#@export var foods_loaded_canvas_layer: CanvasLayer

@export var main_container: Container
@export var foods_loaded_container: DietEditorFoodsLoadedContainer

@export var add_food_button: Button
@export var clear_diet_button: Button
@export var submit_diet_button: Button

var current_diet: Diet
var current_sportsman: Sportsman

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")
@onready var game_watch: MainMenuGameWatch = get_tree().get_first_node_in_group("game_watch")


func _ready() -> void:
	get_tree().paused = true
	hide()
	
	foods_in_diet_container.delete_requested.connect(_delete_food)
	foods_loaded_container.food_selected.connect(_add_food_to_diet)
	
	add_food_button.pressed.connect(_open_foods_loaded)
	clear_diet_button.pressed.connect(clear_diet)
	submit_diet_button.pressed.connect(_submit_diet)
	
	current_diet = main_menu.get_current_diet()
	current_sportsman = main_menu.get_current_sportsman()


## Called outside of it.
func update_diet(diet: Diet, sportsman: Sportsman) -> void:
	if current_diet != diet:
		current_diet = diet
	
	if current_sportsman != current_sportsman:
		current_sportsman = sportsman
	
	foods_in_diet_container.update_slots(current_diet)
	diet_stats_container.update_stats(current_diet, current_sportsman)
	
	show()


func clear_diet() -> void:
	current_diet = Diet.new()
	current_diet.diet_name = "New Diet from Editor"
	
	current_diet.creation_date_week = int(floorf(game_watch.get_now_simulated_weeks()))
	
	foods_in_diet_container.update_slots(current_diet)
	diet_stats_container.reset_diet()
	
	main_menu.set_current_diet(current_diet)
	foods_in_diet_container.update_slots(current_diet)
	
	#return current_diet


func get_current_diet() -> Diet:
	return current_diet


func _delete_food(food_to_delete: Food, food_weight: float) -> void:
	current_diet.remove_food(food_to_delete, food_weight)
	update_diet(current_diet, current_sportsman)
	main_menu.set_current_diet(current_diet)


func _add_food_to_diet(food: Food, food_weight_g: float) -> void:
	current_diet.add_food(food, food_weight_g)
	update_diet(current_diet, current_sportsman)


func _open_foods_loaded() -> void:
	main_container.hide()
	foods_loaded_container.show()
	
	await foods_loaded_container.food_selected
	foods_loaded_container.hide()
	main_container.show()


func _submit_diet() -> void:
	if not current_diet:
		printerr("No diet to submit.")
		return
	
	diet_submitted.emit(current_diet)
	#get_tree().paused = false
