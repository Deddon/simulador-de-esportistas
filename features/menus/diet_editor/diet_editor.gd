class_name DietEditor
extends Control


@export var foods_in_diet_container: DietEditorFoodsInDietContainer

@export var clear_diet_button: Button

var _diet: Diet


func _ready() -> void:
	get_tree().paused = true
	
	clear_diet_button.pressed.connect(_clear_diet)
	
	var demo1_diet := Diet.new()
	demo1_diet.diet_name = "Demo Diet"
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 100.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 90.0)
	demo1_diet.add_food(preload("res://shared/resources/foods/leite.tres"), 1.0)
	
	update_diet(demo1_diet)


func update_diet(diet: Diet) -> void:
	_diet = diet
	foods_in_diet_container.update_slots(_diet)


func _clear_diet() -> void:
	_diet = null
	foods_in_diet_container.update_slots(_diet)
