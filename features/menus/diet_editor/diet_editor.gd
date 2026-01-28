class_name DietEditor
extends Control


@export var foods_in_diet_container: DietEditorFoodsInDietContainer
@export var diet_stats_container: DietEditorDietStats

@export var clear_diet_button: Button

var _diet: Diet
var _sportsman: Sportsman


func _ready() -> void:
	get_tree().paused = true
	
	clear_diet_button.pressed.connect(_clear_diet)
	
	# ATTENTION: TEMPORARY
	_sportsman = preload("res://shared/resources/sportsman/heloisa_four_hundred_meters_runner.tres")
	
	var demo1_diet := Diet.new()
	demo1_diet.diet_name = "Demo Diet"
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 100.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 90.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 1.0)
	
	update_diet(demo1_diet)


func update_diet(diet: Diet) -> void:
	_diet = diet
	foods_in_diet_container.update_slots(_diet)
	print_debug(_sportsman)
	diet_stats_container.update_stats(_diet, _sportsman)


func _clear_diet() -> void:
	_diet = null
	foods_in_diet_container.update_slots(_diet)
	diet_stats_container.update_stats(_diet)
