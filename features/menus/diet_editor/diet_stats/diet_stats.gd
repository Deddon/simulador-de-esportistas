class_name DietEditorDietStats
extends Control


@export var diet_editor: DietEditor
@export var on_diet_container: Container
@export var no_diet_container: Container
@export var create_diet_button: Button

@export_group("Diet Name")
@export var diet_name_label: Label
@export var diet_name_editor_line_edit: LineEdit
@export var change_diet_name_button: Button

@export_group("Energy")
@export var sportsman_get_label: Label
@export var diet_vct_label: Label

@export_group("Macros")
@export var macros_container: Container
@export var grams_container: Container
@export var cho_grams_label: Label
@export var ptn_grams_label: Label
@export var lip_grams_label: Label
@export var grams_per_kg_container: Container
@export var cho_g_per_kg_label: Label
@export var ptn_g_per_kg_label: Label
@export var lip_g_per_kg_label: Label

@export_group("Buttons")
@export var buttons_container: Container
@export var check_diet_button: Button
@export var check_guidelines_button: Button

var current_diet: Diet
var current_sportsman: Sportsman

@onready var main_menu: MainMenu = get_tree().get_first_node_in_group("main_menu")


func _ready() -> void:
	change_diet_name_button.pressed.connect(_request_new_diet_name)
	create_diet_button.pressed.connect(reset_diet)
	
	diet_name_editor_line_edit.hide()
	
	on_diet_container.hide()
	no_diet_container.show()
	# Do not load macros stats or buttons at first.
	macros_container.modulate.a = 0.0
	buttons_container.modulate.a = 0.0


func update_stats(diet: Diet, sportsman: Sportsman) -> void:
	current_diet = diet
	current_sportsman = sportsman
	
	#macros_container.modulate.a = 1.0
	#buttons_container.modulate.a = 0.0
	
	#update_sportsman_name
	sportsman_get_label.text = str(
		"GET %s: " % current_sportsman.get_sportsman_name(true),
		snappedf(current_sportsman.calculate_energy(), 0.1), " kcal"
	)
	
	_update_diet_name()
	
	if current_diet.get_foods().size() < 1:
		#reset_diet()
		return
	
	#var diet_short_name = _shorten_diet_name()
	#diet_vct_label.text = str(diet_short_name, ": ", current_diet.calculate_energy(), " kcal")
	_update_macros()
	
	on_diet_container.show()
	no_diet_container.hide()


func reset_diet() -> void:
	current_diet = Diet.new()
	current_diet.diet_name = "New Diet From Editor"
	main_menu.set_current_diet(current_diet)
	
	update_stats(current_diet, current_sportsman)
	on_diet_container.show()
	
	macros_container.modulate.a = 0.0
	buttons_container.modulate.a = 0.0
	
	#_clear_diet()


func _update_diet_name() -> void:
	var diet_short_name: String = current_diet.diet_name
	diet_name_label.text = current_diet.diet_name
	diet_name_editor_line_edit.text = current_diet.diet_name
	
	if diet_short_name.length() > 9:
		diet_short_name = diet_short_name.substr(0, 8) + "."
	
	diet_vct_label.text = str(diet_short_name, ": ", current_diet.calculate_energy(), " kcal")


#func _shorten_diet_name() -> String:
	#var diet_name_to_fit_space: String = current_diet.diet_name
	#diet_name_label.text = current_diet.diet_name
	#diet_name_editor_line_edit.text = current_diet.diet_name
	#
	#if diet_name_to_fit_space.length() > 9:
		#diet_name_to_fit_space = diet_name_to_fit_space.substr(0, 8) + "."
	#
	#return diet_name_to_fit_space


func _update_macros() -> void:
	var diet_macros: Dictionary = current_diet.get_composition()
	cho_grams_label.text = str(diet_macros["CHO"], " g")
	ptn_grams_label.text = str(diet_macros["PTN"], " g")
	lip_grams_label.text = str(diet_macros["LIP"], " g")
	
	#if not current_sportsman:
		#grams_per_kg_container.hide()
		#return
	
	var sportsman_weight: float = current_sportsman.weight_kg
	cho_g_per_kg_label.text = str(
		snappedf(sportsman_weight / diet_macros["CHO"], 0.1),
		" g/kg"
	)
	ptn_g_per_kg_label.text = str(
		snappedf(sportsman_weight / diet_macros["PTN"], 0.1),
		" g/kg"
	)
	lip_g_per_kg_label.text = str(
		snappedf(sportsman_weight / diet_macros["LIP"], 0.1),
		" g/kg"
	)
	
	#grams_per_kg_container.show()
	macros_container.modulate.a = 1.0
	buttons_container.modulate.a = 1.0


func _request_new_diet_name() -> void:
	diet_name_label.hide()
	diet_name_editor_line_edit.show()
	diet_name_editor_line_edit.grab_focus()
	
	await diet_name_editor_line_edit.text_submitted
	
	var new_diet_name: String = diet_name_editor_line_edit.text.strip_edges()
	
	if new_diet_name.is_empty():
		new_diet_name = diet_name_label.text
	
	diet_name_editor_line_edit.hide()
	diet_name_label.show()
	
	current_diet.set_diet_name(new_diet_name)
	_update_diet_name()


#func _clear_diet() -> void:
	#no_diet_container.hide()
	#on_diet_container.show()
