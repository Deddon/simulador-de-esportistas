class_name SportsmanProfileFoodPlanOverview
extends Control


@export var diet_foods_overview_container: SportsmanProfileDietFoodsOverviewContainer

var _diet: Diet


func _ready() -> void:
	var demo_diet := Diet.new()
	
	demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 50)
	demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 50)
	demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 100)
	demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 100)
	demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 10)
	demo_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 20)
	demo_diet.add_food(preload("res://shared/resources/foods/abacate.tres"), 33)
	_diet = demo_diet
	diet_foods_overview_container.update_diet(_diet)
