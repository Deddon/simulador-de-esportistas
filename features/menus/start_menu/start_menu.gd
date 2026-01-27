class_name StartMenu
extends Control


@export var main_menu_packed_scene: PackedScene
@export var player_name_line_edit: LineEdit
@export var professional_name_and_crn_label: Label


func _ready() -> void:
	player_name_line_edit.text_submitted.connect(_update_professional_name)


func _update_professional_name(submitted_name: String) -> void:
	submitted_name = submitted_name.strip_edges()
	var random_CRN: String = _calc_random_CRN()
	var final_name: String
	
	if " " in submitted_name:
		var full_name_array: PackedStringArray = submitted_name.split(" ")
		final_name = " ".join(full_name_array.slice(0, 2))
		
		professional_name_and_crn_label.text = (
			"Nutricionista %s" % final_name + 
			"\nCRN: " + random_CRN
		)
	
	else:
		final_name = submitted_name
		professional_name_and_crn_label.text = (
			"Nutricionista " + final_name + "\nCRN: " + random_CRN
		)
	
	GameBuffer.player_data = PackedStringArray([final_name, random_CRN])
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(main_menu_packed_scene)


func _calc_random_CRN() -> String:
	var final_CRN: String = ""
	
	for i in 5:
		final_CRN += str(randi_range(1, 9))
	
	final_CRN += "-3"
	return final_CRN
