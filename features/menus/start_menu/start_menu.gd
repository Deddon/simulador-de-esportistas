class_name StartMenu
extends Control


@export var player_name_line_edit: LineEdit
@export var professional_name_and_crn_label: Label


func _ready() -> void:
	player_name_line_edit.text_submitted.connect(_update_professional_name)


func _update_professional_name(submitted_name: String) -> void:
	submitted_name = submitted_name.strip_edges()
	
	if " " in submitted_name:
		var full_name_array: PackedStringArray = submitted_name.split(" ")
		professional_name_and_crn_label.text = (
			"Nutricionista. %s %s" % [full_name_array[0], full_name_array[-1]] + 
			"\nCRN: " + _calc_random_CRN()
		)
		professional_name_and_crn_label.text += "\nCRN: " + _calc_random_CRN()
	
	else:
		professional_name_and_crn_label.text = (
			"Nutricionista. " + submitted_name + "\nCRN: " + _calc_random_CRN()
		)
	
	GameBuffer.player_name = submitted_name
	await get_tree().create_timer(3).timeout
	print("TRYING TO CHANGE SCENE")


func _calc_random_CRN() -> String:
	var final_CRN: String = ""
	
	for i in 5:
		final_CRN += str(randi_range(1, 9))
	
	final_CRN += "-3"
	return final_CRN
