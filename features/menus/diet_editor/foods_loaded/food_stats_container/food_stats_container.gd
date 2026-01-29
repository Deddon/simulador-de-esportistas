class_name DietEditorFoodStatsContainer
extends Control


var current_food: Food


func get_stats_from(food: Food) -> void:
	current_food = food
	print_debug(food.name)
