extends Control


@export var diet_stats_container: VisaoGeralDietStatsContainer
@export var no_diet_container: Container

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")

var current_diet: Diet


func _ready() -> void:
	main_menu.new_diet_set.connect(func():
		_update_diet_stats(main_menu.get_current_diet())
	)
	
	await get_tree().create_timer(0.2).timeout
	current_diet = main_menu.get_current_diet()
	
	no_diet_container.show()
	diet_stats_container.hide()
	
	_update_diet_stats(current_diet)


func _update_diet_stats(diet: Diet):
	current_diet = diet
	
	if current_diet:
		diet_stats_container.update_from(current_diet)
		no_diet_container.hide()
		diet_stats_container.show()
		
	else:
		no_diet_container.show()
		diet_stats_container.hide()
