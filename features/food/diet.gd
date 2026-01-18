class_name Diet
extends Resource


signal food_added(food: Food, food_weight_g: float)
signal food_removed(food: Food)

@export var diet_name: String
@export var _foods_in_diet: Dictionary[String, Dictionary] = {}


func add_food(food: Food, food_weight_g: float) -> void:
	_foods_in_diet[food.name] = {"food": food, "weight": food_weight_g}
	food_added.emit(food, food_weight_g)


func remove_food(food: Food) -> void:
	var has_food_been_removed: bool = _foods_in_diet.erase(food.name)
	if has_food_been_removed:
		food_removed.emit(food)


func get_foods() -> Array[Food]:
	var _foods_array: Array[Food]
	for food_dict: Dictionary in _foods_in_diet.values():
		_foods_array.append(food_dict.food)
	
	return _foods_array


func _to_string() -> String:
	if not diet_name:
		return "<Diet>"
	
	return "<%s>" % diet_name
