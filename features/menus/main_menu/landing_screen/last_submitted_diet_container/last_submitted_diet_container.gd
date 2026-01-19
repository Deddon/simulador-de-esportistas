class_name MainMenuLastSubmittedDiet
extends Control


@export var when_no_diet_container: Container
@export var when_diet_container: Container
@export var open_diet_manager_button: Button
@export var diet_name_label: Label
@export var cho_label: Label
@export var ptn_label: Label
@export var lip_label: Label
@export var fibers_label: Label

@onready var _diet: Diet = GameBuffer.get_buffered_diet()


func _ready() -> void:
	open_diet_manager_button.pressed.connect(_open_diet_manager)
	
	if not _diet:
		when_no_diet_container.show()
		when_diet_container.hide()
	
	else:
		when_diet_container.show()
		when_no_diet_container.hide()
		_show_food_stats_on_diet()


func _show_food_stats_on_diet() -> void:
	diet_name_label.text = str(
		_diet.diet_name, "\n\n",
		"VCT: ", _diet.get_energy(), " kcal"
	)
	
	var diet_composition := _diet.get_composition()
	cho_label.text = str("CHO: ", diet_composition["CHO"], " g")
	ptn_label.text = str("PTN: ", diet_composition["PTN"], " g")
	lip_label.text = str("LIP: ", diet_composition["LIP"], " g")
	fibers_label.text = str("LIP: ", diet_composition["fibers"], " g")


func _open_diet_manager() -> void:
	print_debug("Trying to open diet manager, but no scene associated.")
