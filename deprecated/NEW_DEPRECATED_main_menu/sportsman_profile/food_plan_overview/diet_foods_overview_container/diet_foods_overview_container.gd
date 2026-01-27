class_name SportsmanProfileDietFoodsOverviewContainer
extends Control


@export var no_diet_container: Container
@export var diet_buffered_container: Container
@export var diet_foods_container: Container
@export var food_slot_packed_scene: PackedScene


var _diet: Diet


func _ready() -> void:
	pass
	#var demo_diet := Diet.new()
	#
	#demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 50)
	#demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 50)
	#demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 100)
	#demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 100)
	#demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 10)
	#demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 20)
	#demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 33)
	#demo_diet.remove_food(preload("res://shared/resources/foods/abacate.tres"))
	#update_diet(demo_diet)


func update_diet(diet: Diet) -> void:
	if not diet:
		return
	
	_diet = diet
	
	for food_dict: Dictionary in _diet.get_foods():
		var food_slot: DietOverviewFoodSlot = food_slot_packed_scene.instantiate()
		food_slot.update_food(food_dict.food, food_dict.weight)
		diet_foods_container.add_child(food_slot)
