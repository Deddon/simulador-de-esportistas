class_name DietEditorFoodsLoadedContainer
extends Control


signal food_selected(food: Food, food_weight_g: float)

@export var submit_food_button: Button

@export var foods_loaded_grid: GridContainer
@export var food_loaded_slot_packed_scene: PackedScene

@export var foods_stats_container: DietEditorFoodStatsContainer


func _ready() -> void:
	submit_food_button.pressed.connect(_emit_food_selected)
	
	update_loaded_foods()


func update_loaded_foods() -> void:
	for child: Control in foods_loaded_grid.get_children():
		child.queue_free()
	
	var loaded_foods: Array[Food] = Loader.load_all_foods()
	for food: Food in loaded_foods:
		for i in 2:
			var food_slot: DietEditorFoodLoadedSlot = food_loaded_slot_packed_scene.instantiate()
			food_slot.set_slot_food(food)
			food_slot.food_selected.connect(_handle_food_selection)
			foods_loaded_grid.add_child(food_slot)


func _handle_food_selection(selected_food: Food) -> void:
	foods_stats_container.get_stats_from(selected_food)


func _emit_food_selected() -> void:
	var food_dict: Dictionary = foods_stats_container.get_selected_food()
	if food_dict.food:
		food_selected.emit(food_dict.food, food_dict.weight)
