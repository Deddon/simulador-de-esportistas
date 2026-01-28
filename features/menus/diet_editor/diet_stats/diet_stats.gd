class_name DietEditorDietStats
extends Control


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

var _diet: Diet
var _sportsman: Sportsman


func _ready() -> void:
	change_diet_name_button.pressed.connect(_request_new_diet_name)
	create_diet_button.pressed.connect(reset_diet)
	
	diet_name_editor_line_edit.hide()
	macros_container.modulate.a = 0.0
	buttons_container.modulate.a = 0.0


func update_stats(diet: Diet, sportsman: Sportsman = null) -> void:
	_diet = diet
	if sportsman and sportsman != _sportsman:
		_sportsman = sportsman
	
	if not _diet:
		push_error("No Diet attached.")
		_clear_diet()
		return
	
	if _diet.get_foods().size() == 0:
		macros_container.modulate.a = 0.0
		buttons_container.modulate.a = 0.0
		_clear_diet()
		return
	
	var diet_short_name = _shorten_diet_name()
	diet_vct_label.text = str(diet_short_name, ": ", _diet.calculate_energy(), " kcal")
	
	if _sportsman:
		sportsman_get_label.text = str(
			"GET %s: " % _sportsman.get_sportsman_name(true),
			snappedf(_sportsman.calculate_energy(), 0.1), " kcal"
		)
	
	_update_macros()


func _shorten_diet_name() -> String:
	var diet_name_to_fit_space: String = _diet.diet_name
	diet_name_label.text = _diet.diet_name
	diet_name_editor_line_edit.text = _diet.diet_name
	
	if diet_name_to_fit_space.length() > 9:
		diet_name_to_fit_space = diet_name_to_fit_space.substr(0, 8) + "."
	
	return diet_name_to_fit_space


func _update_macros() -> void:
	macros_container.modulate.a = 1.0
	buttons_container.modulate.a = 1.0
	
	var diet_macros: Dictionary = _diet.get_composition()
	cho_grams_label.text = str(diet_macros["CHO"], " g")
	ptn_grams_label.text = str(diet_macros["PTN"], " g")
	lip_grams_label.text = str(diet_macros["LIP"], " g")
	
	if not _sportsman:
		grams_per_kg_container.hide()
		return
	
	var sportsman_weight: float = _sportsman.weight_kg
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
		
	grams_per_kg_container.show()


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
	
	if _diet:
		_diet.set_diet_name(new_diet_name)
		update_stats(_diet)


func _clear_diet() -> void:
	no_diet_container.hide()
	on_diet_container.show()


func reset_diet() -> void:
	_diet = Diet.new()
	_diet.diet_name = "Diet1"
	
	_clear_diet()
	
	update_stats(_diet)
