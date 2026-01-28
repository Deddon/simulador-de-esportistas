class_name DietEditorFoodSlot
extends Control


signal slot_selected(selected_food: Dictionary)

@export var food_icon_texture_rect: TextureRect
@export var food_name_label: Label
@export var food_stats_info_label: Label

var _food: Food
var _weight: float = -1.0

@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(_handle_slot_press)


func update_food(food_dict: Dictionary) -> void:
	_food = food_dict.food
	_weight = food_dict.weight
	
	food_icon_texture_rect.texture = _food.texture
	food_name_label.text = _food.name
	
	var food_energy: float = snappedf(_food.get_energy() * (_weight / 100.0), 0.1)
	food_stats_info_label.text = str(_weight, " g - ", food_energy, " kcal")


func _handle_slot_press() -> void:
	if _food:
		slot_selected.emit({"food": _food, "weight": _weight})
