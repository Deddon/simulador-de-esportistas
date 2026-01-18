extends Control


func _ready() -> void:
	var debug_diet: Diet = Diet.new()
	debug_diet.diet_name = "Debug Diet"
	
	debug_diet.food_added.connect(func(f: Food, _f_weight: float): print("Food added: ", f.name))
	debug_diet.food_removed.connect(func(f: Food): print("Food removed: ", f.name))
	
	print("Diet created: ", debug_diet, "\n")
	
	var food_a := Food.new()
	food_a.name = "Carne Grelhada"
	
	var food_b := Food.new()
	food_b.name = "Suco de Laranja"
	
	var food_c := Food.new()
	food_c.name = "Ovo frito"
	
	debug_diet.add_food(food_a, 70.0)
	debug_diet.add_food(food_b, 30.0)
	debug_diet.add_food(food_c, 50.0)
	
	print("\nFoods on Diet: ")
	for f: Food in debug_diet.get_foods():
		print(f.name)
	
	var food_never_added := Food.new()
	food_never_added.name = "Banana"
	
	debug_diet.remove_food(food_a)
	
	print("\nFoods on Diet after removing Carne Grelhada:")
	for f: Food in debug_diet.get_foods():
		print(f.name)
	
	get_tree().quit()
