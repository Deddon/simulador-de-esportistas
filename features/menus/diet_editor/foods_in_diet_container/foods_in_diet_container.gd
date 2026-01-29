class_name DietEditorFoodsInDietContainer
extends Control


@export var food_slot_packed_scene: PackedScene
@export var food_slot_container: Container
@export var on_diet_container: Container
@export var no_diet_container: Container


func _ready() -> void:
	on_diet_container.hide()
	no_diet_container.show()


func update_slots(diet: Diet) -> void:
	for child: Control in food_slot_container.get_children():
		child.queue_free()
	
	if not diet:
		push_error("Diet is null.")
		on_diet_container.hide()
		no_diet_container.show()
		return
	
	if diet.get_foods().size() == 0:
		on_diet_container.hide()
		no_diet_container.show()
		return
	
	diet.changed.connect(func():
		print_debug("Diet changed signal triggered, trying to update foods.")
		update_slots.bind(diet)
	)
	
	for food_dict: Dictionary in diet.get_foods():
		var food_slot = food_slot_packed_scene.instantiate() as DietEditorFoodSlot
		food_slot.update_food(food_dict)
		food_slot.slot_selected.connect(_handle_slot_press)
		
		food_slot_container.add_child(food_slot)
	
	on_diet_container.show()
	no_diet_container.hide()


func _handle_slot_press(food_dict: Dictionary) -> void:
	print_debug("Slot with food %s was pressed." % food_dict.food.name)
