class_name Diet
extends Resource


signal diet_changed()
signal food_added(food: Food, food_weight_g: float)
signal food_removed(food: Food)

@export var diet_name: String:
	set = _set_new_name
@export var _foods_in_diet: Array[Dictionary] = []
@export var short_description: String


func add_food(food: Food, food_weight_g: float) -> void:
	_foods_in_diet.append({
		"food": food,
		"weight": food_weight_g
	})
	food_added.emit(food, food_weight_g)
	diet_changed.emit()


func remove_food(target_food: Food) -> void:
	var inversed_foods_in_diet: Array[Dictionary] = _foods_in_diet.duplicate()
	inversed_foods_in_diet.reverse()
	
	for food_index: int in inversed_foods_in_diet.size():
		var current_food: Dictionary = inversed_foods_in_diet[food_index]
		
		if current_food.food == target_food:
			_foods_in_diet.remove_at(food_index)
			food_removed.emit(current_food)
			diet_changed.emit()


func set_diet_name(new_name: String) -> void:
	diet_name = new_name
	diet_changed.emit()


func get_foods() -> Array[Dictionary]:
	return _foods_in_diet


func get_composition() -> Dictionary[String, float]:
	var diet_composition: Dictionary[String, float] = {
		"CHO": 0.0,
		"PTN": 0.0,
		"LIP": 0.0,
		"fibers": 0.0,
	}
	
	for food_dict: Dictionary in _foods_in_diet:
		var current_food: Food = food_dict.food
		var weight_proportion: float = food_dict.weight / 100.0
		
		for nutrient_name: String in current_food.composition.keys():
			if not diet_composition.has(nutrient_name):
				push_error("Nutrient %s isen't part of the know nutrients. Food: %s." % [
					nutrient_name, current_food.name
				])
				continue
				
			diet_composition[nutrient_name] += current_food.composition[nutrient_name] * weight_proportion
	
	return diet_composition


func calculate_energy() -> float:
	var energy_sum: float = 0.0
	
	for food_dict: Dictionary in _foods_in_diet:
		energy_sum += food_dict.food.get_energy()
	
	return energy_sum


func _set_new_name(new_name: String) -> void:
	if not new_name.is_empty():
		diet_name = new_name
		diet_changed.emit()


func _to_string() -> String:
	if not diet_name:
		return "<Diet>"
	
	return "<%s>" % diet_name
