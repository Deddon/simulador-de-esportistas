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

@export var diet_history_container: PlanejamentoAlimentarDietHistoryContainer

var _diet: Diet
var _sportsman: Sportsman

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")


func _ready() -> void:
	_sportsman = main_menu.current_sportsman
	_diet = _sportsman.current_diet
	
	if not _diet:
		current_diet_container.hide()
		no_diet_container.show()
		return
	
	no_diet_container.hide()
	update_diet()
	
	var diets_history: Array[Diet] = _sportsman.get_submitted_diets_history()
	if diets_history.size() > 0:
		diet_history_container.show_history()
	
	else:
		diet_history_container.hide_history()


func update_diet() -> void:
	current_diet_container.show()
	var sportsman_energy: float = main_menu.current_sportsman.calculate_energy()
	var diet_energy: float = _diet.calculate_energy()
	var diet_macros: Dictionary = _diet.get_composition()
	
	diet_name_label.text = "Dieta Atual\n" + _diet.diet_name
	desired_get_label.text = str("GET Desejado: ", sportsman_energy + 180.0, " kcal")
	get_label.text = str("GET: ", sportsman_energy, " kcal")
	calorie_difference_label.text = str("Diferença: +", 180.0, " kcal")
	
	diet_vct_label.text = str("VCT Dieta: ", diet_energy, " kcal")
	cho_label.text = str("CHO: ", diet_macros["CHO"], " g")
	ptn_label.text = str("PTN: ", diet_macros["PTN"], " g")
	lip_label.text = str("LIP: ", diet_macros["LIP"], " g")
