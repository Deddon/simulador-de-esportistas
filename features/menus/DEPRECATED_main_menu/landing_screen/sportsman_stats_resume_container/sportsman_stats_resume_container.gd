class_name MainMenuSportsmanStatsResumeContainer
extends Control


@export var sportsman_name_label: Label
@export var sportsman_weight_info_label: Label
@export var sportsman_sport_name_label: Label
@export var intake_assessment_label: Label

@onready var _sportsman: Sportsman = GameBuffer.get_buffered_sportsman()


func _ready() -> void:
	if not _sportsman:
		push_error("No sportsman on GameBuffer.")
		return
	
	sportsman_name_label.text = _sportsman.name
	sportsman_weight_info_label.text = str(
		"Peso: ", _sportsman.weight_kg, " kg\n",
		"Meta: ", _sportsman.weight_kg + (randi_range(-10, 10) + 10), ".0 kg\n\n",
		"Ganho de peso recente:\n", randi_range(-3, 3), ".0 kg"
	)
	
	var sportsman_energy_need: float = _sportsman.calculate_energy()
	intake_assessment_label.text = str(
		"Recordatório:\n",
		int(randf_range(sportsman_energy_need - 200.0, sportsman_energy_need + 200.0)),
		" kcal"
	)
	
	sportsman_sport_name_label.text = Constants.get_sport_name(_sportsman)
