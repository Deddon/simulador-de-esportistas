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
