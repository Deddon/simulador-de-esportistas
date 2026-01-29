class_name DietEditorFoodSlot
extends Control


signal slot_selected(selected_food: Dictionary)
signal delete_pressed(selected_food: Food, food_weight_g: float)

@export var food_icon_texture_rect: TextureRect
@export var food_name_label: Label
@export var food_stats_info_label: Label
@export var delete_food_button: Button

var _food: Food
var _weight: float = -1.0
var delete_tries: int = 0

@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(_handle_slot_press)
	delete_food_button.pressed.connect(_request_delete)


func update_food(food_dict: Dictionary) -> void:
	_food = food_dict.food
	_weight = food_dict.weight
	
	food_icon_texture_rect.texture = _food.texture
	food_name_label.text = _food.name
	
	food_stats_info_label.text = str(_weight, " g - ", _food.get_energy_from_weight(_weight), " kcal")


func _handle_slot_press() -> void:
	if _food:
		slot_selected.emit({"food": _food, "weight": _weight})


func _request_delete() -> void:
	delete_tries += 1
	
	if delete_tries == 1:
		delete_food_button.text = "Deletar?"
		
		get_tree().create_timer(2).timeout.connect(_reset_delete_tries)
		return
	
	if _food and _weight > 0.0:
		var red_tween: Tween = create_tween()
		red_tween.tween_property(self, "modulate", Color.RED, 0.5)
		
		await get_tree().create_timer(0.8).timeout
		call_deferred("queue_free")
		delete_pressed.emit(_food, _weight)


func _reset_delete_tries() -> void:
	delete_tries = 0
	delete_food_button.text = "X"
