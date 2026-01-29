class_name DietEditorFoodLoadedSlot
extends Control


signal food_selected(food: Food)

@export var food_icon_texture_rect: TextureRect

var current_food: Food

@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(func():
		if current_food:
			food_selected.emit(current_food)
	)


func set_slot_food(food: Food) -> void:
	current_food = food
	food_icon_texture_rect.texture = current_food.texture
