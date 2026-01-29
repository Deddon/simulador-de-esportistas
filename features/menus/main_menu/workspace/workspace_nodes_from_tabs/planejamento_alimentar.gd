class_name WorkspacePlanejamentoAlimentar
extends Control


## TODO: Connect button to edit diet to this scene.
@export var diet_editor_packed_scene: PackedScene

@export_group("Nodes")
@export var current_diet_container: Container
@export var diet_name_label: Label
@export var desired_get_label: Label
@export var get_label: Label
@export var calorie_difference_label: Label
@export var diet_vct_label: Label
@export var cho_label: Label
@export var ptn_label: Label
@export var lip_label: Label
@export var no_diet_container: Container
@export var edit_diet_button: Button
@export var create_first_diet_button: Button

@export var diet_history_container: PlanejamentoAlimentarDietHistoryContainer

var current_diet: Diet
var current_sportsman: Sportsman

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")
@onready var diet_editor: DietEditor = get_tree().get_first_node_in_group("diet_editor")


func _ready() -> void:
	# It is not intended to load if no main menu.
	if not main_menu:
		push_error("No Main Menu found.")
		return
	
	edit_diet_button.pressed.connect(_instantiate_diet_editor)
	create_first_diet_button.pressed.connect(_instantiate_diet_editor)
	main_menu.new_diet_set.connect(_update_diet_from_main_menu)
	
	# By default, shows no diet UI.
	no_diet_container.show()
	current_diet_container.hide()
	
	current_sportsman = main_menu.get_current_sportsman()
	current_diet = main_menu.get_current_diet()
	
	if not current_diet:
		return
	
	update_diet()
	update_diet_history_container()


## Shows stats of the diet
func update_diet() -> void:
	no_diet_container.hide()
	current_diet_container.show()
	
	var sportsman_energy: float = main_menu.current_sportsman.calculate_energy()
	var diet_energy: float = current_diet.calculate_energy()
	var diet_macros: Dictionary = current_diet.get_composition()
	
	diet_name_label.text = "Dieta Atual\n" + current_diet.diet_name
	desired_get_label.text = str("GET Desejado: ", sportsman_energy + 180.0, " kcal")
	get_label.text = str("GET: ", sportsman_energy, " kcal")
	calorie_difference_label.text = str("Diferença: +", 180.0, " kcal")
	
	diet_vct_label.text = str("VCT Dieta: ", diet_energy, " kcal")
	cho_label.text = str("CHO: ", diet_macros["CHO"], " g")
	ptn_label.text = str("PTN: ", diet_macros["PTN"], " g")
	lip_label.text = str("LIP: ", diet_macros["LIP"], " g")


func update_diet_history_container() -> void:
	if current_sportsman.get_submitted_diets_history().size() > 0:
		diet_history_container.show_history()
	
	else:
		diet_history_container.hide_history()


func _instantiate_diet_editor() -> void:
	# Instantiate if not hided in the scene.
	if not diet_editor:
		diet_editor = diet_editor_packed_scene.instantiate()
		get_tree().root.add_child(diet_editor)
	
	if not diet_editor.diet_submitted.is_connected(_handle_submitting_diet):
		diet_editor.diet_submitted.connect(_handle_submitting_diet)
	
	main_menu.hide()
	diet_editor.update_diet(current_diet, current_sportsman)
	diet_editor.show()


func _handle_submitting_diet(new_submitted_diet: Diet) -> void:
	diet_editor.hide()
	get_tree().paused = false
	main_menu.show()
	
	update_diet()
	main_menu.set_current_diet(new_submitted_diet)
	
	#print_debug("Check if main menu updated submitted diet.")


func _update_diet_from_main_menu() -> void:
	current_diet = main_menu.get_current_diet()
	update_diet()
	print_debug("\nNew diet: %s." % current_diet.diet_name)
