class_name SportsmanSelectionSportsmanProfile
extends Control


signal weight_selected(weight_kg: float)

@export var submit_sportsman_button: Button
@export var sportsman_name_label: Label
@export var weight_label: Label
@export var weight_slider: HSlider
@export var energy_label: Label

var _demo_sportsman: Sportsman


func _ready() -> void:
	weight_slider.value_changed.connect(_update_weight_from_slider)
	weight_slider.drag_ended.connect(_update_energy_need)
	
	var name_line_edit: LineEdit
	name_line_edit = get_tree().get_first_node_in_group("sportsman_name_line_edit")
	if name_line_edit:
		name_line_edit.text_submitted.connect(_update_sportsman_name)
	
	sportsman_name_label.text = ""
	
	weight_label.text = str(int(weight_slider.value), " kg")
	_demo_sportsman = Sportsman.new()
	_demo_sportsman.weight_kg = weight_slider.value
	energy_label.text = str("TMB: ", _demo_sportsman.harris_benedict(), " kcal")


func _update_weight_from_slider(value_changed: float) -> void:
	weight_label.text = str(int(value_changed), " kg")


func _update_energy_need(has_value_changed: bool) -> void:
	if has_value_changed:
		_demo_sportsman.weight_kg = weight_slider.value
		energy_label.text = str("TMB: ", _demo_sportsman.harris_benedict(), " kcal")
		
		weight_selected.emit(weight_slider.value)
		


func _update_sportsman_name(new_name_submitted: String) -> void:
	sportsman_name_label.text = new_name_submitted
