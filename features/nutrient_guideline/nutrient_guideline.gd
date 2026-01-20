class_name NutrientGuideline
extends Resource


@export var name: String = "Guideline"
@export var target_sport: Constants.SportsmanAvailableSports = Constants.SportsmanAvailableSports.NULL
@export_multiline var description: String

@export_group("Compositition Data")
@export var composition_proportion: Dictionary[String, float] = {
	"CHO": 0.0,
	"PTN": 0.0,
	"LIP": 0.0,
	"fibers": 0.0,
}

@export_group("Research Data")
@export var publishers: String = ""
@export var simulated_publish_time_seconds: float = -1.0
@export var research_unlock_ticks: float = -1.0

@export_group("Metadata")
@export var metadata: Dictionary[String, Variant] = {}


func set_publish_date_from_seconds(publish_seconds: float, time_offset: float = 0.0) -> void:
	simulated_publish_time_seconds = publish_seconds + time_offset


func set_ticks_to_unlock_research(ticks: int) -> void:
	research_unlock_ticks = ticks
