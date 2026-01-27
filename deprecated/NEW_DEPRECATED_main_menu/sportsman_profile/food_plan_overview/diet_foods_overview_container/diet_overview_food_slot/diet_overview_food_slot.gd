class_name DietOverviewFoodSlot
extends Control


@export var food_texture_rect: TextureRect
@export var food_name_and_calories_label: Label

var current_food: Array


func update_food(food: Food, food_weight_g: float) -> void:
	current_food = [food, food_weight_g]
	
	food_texture_rect.texture = food.texture
	food_name_and_calories_label.text = str(
		food.name, "\n",
		food_weight_g, " g - ", food.get_energy() * (food_weight_g / 100.0), " kcal"
	)
