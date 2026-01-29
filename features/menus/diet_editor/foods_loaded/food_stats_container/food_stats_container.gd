class_name DietEditorFoodStatsContainer
extends Control


@export var main_container: Container
@export var food_name_label: Label

@export_group("Food Weight")
@export var food_weight_label: Label
@export var food_weight_setter_line_edit: LineEdit

@export_group("Food Macros")
@export var cho_label: Label
@export var ptn_label: Label
@export var lip_label: Label

#@export_group("Diet Macros After Food")
#@export var diet_with_food_label: Label
#@export var cho_g_per_kg_label: Label
#@export var cho_g_label: Label
#@export var ptn_g_per_kg_label: Label
#@export var ptn_g_label: Label
#@export var lip_g_per_kg_label: Label
#@export var lip_g_label: Label

@export_group("Energy")
@export var diet_before_energy_label: Label
@export var diet_after_energy_label: Label

var current_diet: Diet
var current_food: Food
var food_weight_g: float

@onready var diet_editor: DietEditor = get_tree().get_first_node_in_group("diet_editor")


func _ready() -> void:
	main_container.hide()
	
	#current_diet = diet_editor.get_current_diet()
	current_diet = preload("res://shared/resources/diet/demo_diet.tres")


func get_stats_from(food: Food) -> void:
	current_food = food
	food_weight_g = 100.0
	
	food_name_label.text = food.name
	
	food_weight_setter_line_edit.text = str(int(food_weight_g))
	food_weight_label.text = str("Contabilizando ", int(food_weight_g), "g\nde alimento")
	
	var food_proportion: float = (food_weight_g / 100.0)
	cho_label.text = str(snappedf(current_food.composition["CHO"] * food_proportion, 0.1), "g")
	ptn_label.text = str(snappedf(current_food.composition["PTN"] * food_proportion, 0.1), "g")
	lip_label.text = str(snappedf(current_food.composition["LIP"] * food_proportion, 0.1), "g")
	
	var diet_before_energy: float = current_diet.calculate_energy()
	diet_before_energy_label.text = str(snappedf(diet_before_energy, 0.1), " kcal")
	
	var diet_after_energy: float = diet_before_energy + (current_food.get_energy() * food_proportion)
	diet_after_energy_label.text = str(snappedf(diet_after_energy, 0.1), " kcal")
	
	main_container.show()
