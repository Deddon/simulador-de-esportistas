class_name VisaoGeralDietStatsContainer
extends HBoxContainer


@export var name_label: Label
@export var energy_label: Label
@export var creation_date_label: Label
@export var description_label: Label
@export var foods_texture_grid_container: GridContainer

var current_diet: Diet

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")

func _ready() -> void:
	main_menu.new_diet_set.connect(func():
		update_from(main_menu.get_current_diet())
	)


func update_from(diet: Diet) -> void:
	current_diet = diet
	
	if not current_diet:
		await get_tree().create_timer(1.0).timeout
		update_from(main_menu.get_current_diet())
		return
	
	if not current_diet.diet_changed.is_connected(update_from):
		current_diet.diet_changed.is_connected(update_from.bind(current_diet))
	
	name_label.text = current_diet.diet_name
	energy_label.text = str(snappedf(current_diet.calculate_energy(), 0.1), " kcal")
	creation_date_label.text = str("Criada: Semana ", current_diet.creation_date_week)
	description_label.text = current_diet.short_description
	
	var diet_foods: Array[Dictionary] = current_diet.get_foods()
	
	var first_four_foods: Array[Food] = []
	# Get just the least amount between 4 and the number of foods in diet. If there are 20 foods,
	# pick 4, if there is one, pick it.
	for i in min(diet_foods.size(), 4):
		first_four_foods.append(diet_foods[i].food)
	
	for texture_rect_index: int in foods_texture_grid_container.get_child_count():
		var current_food_texture_rect: TextureRect
		current_food_texture_rect = foods_texture_grid_container.get_child(texture_rect_index)
		
		# If there is no food at this index, set texture to none.
		if texture_rect_index <= first_four_foods.size() - 1:
			current_food_texture_rect.texture = first_four_foods[texture_rect_index].texture
			
		else:
			current_food_texture_rect.texture = null
