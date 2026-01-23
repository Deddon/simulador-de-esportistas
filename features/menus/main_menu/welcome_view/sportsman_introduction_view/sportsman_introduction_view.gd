class_name SportsmanIntroductionView
extends Control


signal dismissed()

@export var name_label: Label
@export var current_sport_label: Label
@export var weight_label: Label
@export var description_label: RichTextLabel
@export var dismiss_button: Button

var _sportsman: Sportsman


func _ready() -> void:
	hide()
	dismiss_button.pressed.connect(dismissed.emit)


func update_and_show(s: Sportsman) -> void:
	_sportsman = s
	name_label.text = _sportsman.name
	current_sport_label.text = Constants.get_sport_name(_sportsman)
	weight_label.text = str("Peso: ", _sportsman.weight_kg, " kg")
	description_label.text = _sportsman.description
	
	show()
