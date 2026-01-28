class_name DietEditorDietStats
extends Control


signal diet_renamed(new_name: String)

@export var diet_name_label: Label
@export var diet_name_editor_line_edit: LineEdit
@export var change_diet_name_button: Button

@export var sportsman_get_label: Label
@export var diet_vct_label: Label

@export var cho_grams_label: Label
@export var ptn_grams_label: Label
@export var lip_grams_label: Label
@export var cho_g_per_kg_label: Label
@export var ptn_g_per_kg_label: Label
@export var lip_g_per_kg_label: Label

@export var check_diet_button: Button
@export var check_guidelines_button: Button

var _diet: Diet
var _sportsman: Sportsman

func _ready() -> void:
	diet_name_editor_line_edit.hide()
	change_diet_name_button.pressed.connect(_request_new_diet_name)


func update_stats(diet: Diet, sportsman: Sportsman = null) -> void:
	_diet = diet
	if sportsman and sportsman != _sportsman:
		_sportsman = sportsman
	
	var diet_name_to_fit_space: String = _diet.diet_name
	diet_name_label.text = _diet.diet_name
	diet_name_editor_line_edit.text = _diet.diet_name
	
	if diet_name_to_fit_space.length() > 9:
		diet_name_to_fit_space = diet_name_to_fit_space.substr(0, 8) + "."
	
	diet_vct_label.text = str(diet_name_to_fit_space, ": ", _diet.calculate_energy(), " kcal")
	
	var diet_macros: Dictionary = diet.get_composition()
	cho_grams_label.text = str(diet_macros["CHO"], " g")
	ptn_grams_label.text = str(diet_macros["PTN"], " g")
	lip_grams_label.text = str(diet_macros["LIP"], " g")
	
	var sportsman_weight: float = sportsman.weight_kg
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
		diet_renamed.emit(new_diet_name)
