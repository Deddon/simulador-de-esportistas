class_name Sportsman
extends Resource


const DEFAULT_HEIGHT_CM := 180
const DEFAULT_AGE_YEARS := 24

const DEFAULT_TRAINING_WEEK_FREQUENCY := 5
const DEFAULT_TRAINING_DURATION_MIN := 40
const DEFAULT_AVERAGE_TRAINING_MINUTES_DAY := (DEFAULT_TRAINING_WEEK_FREQUENCY * DEFAULT_TRAINING_DURATION_MIN) / 7.0


@export var name: String
@export var weight_kg: float = 60.0:
	set = _set_new_weight
@export var current_sport: Constants.SportsmanAvailableSports = Constants.SportsmanAvailableSports.NULL
@export var ideal_guideline: NutrientGuideline
@export var current_diet: Diet:
	set = _add_diet

@export var _submitted_diets_history: Array[Diet]
@export var _events_history: Array[SportsEventResult]
@export var _body_fat_percentage: float = 16.0
@export var _max_vo2_ml_kg_min: float = 41.0
@export var _weight_history_kg: Array[float] = []


func calculate_energy() -> float:
	var MBR: float = male_harris_benedict()
	var MET: float = met_expenditure()
	return MBR + MET


func male_harris_benedict() -> float:
	return 66.47 + (13.75 * weight_kg) + (5.003 * DEFAULT_HEIGHT_CM) - (6.775 * DEFAULT_AGE_YEARS)


func female_harris_benedict() -> float:
	return 0.0


func met_expenditure() -> float:
	var calories_per_minute: float
	calories_per_minute = (Constants.AvailableSportsMet[current_sport] * 3.5 * weight_kg) / 200
	return calories_per_minute * DEFAULT_AVERAGE_TRAINING_MINUTES_DAY


func add_finished_event_result(event_result: SportsEventResult) -> void:
	_events_history.append(event_result)


func get_events_history() -> Array[SportsEventResult]:
	return _events_history


func set_body_fat(new_body_fat_percentage: float) -> void:
	if new_body_fat_percentage > 0.0:
		_body_fat_percentage = new_body_fat_percentage


func get_body_fat() -> float:
	return _body_fat_percentage


func set_max_vo2(new_max_vo2_ml_kg_min: float) -> void:
	if new_max_vo2_ml_kg_min > 0.0:
		_max_vo2_ml_kg_min = new_max_vo2_ml_kg_min


func get_max_vo2() -> float:
	return _max_vo2_ml_kg_min


func get_weight_history() -> Array[float]:
	return _weight_history_kg


func _set_new_weight(new_weight_kg: float) -> void:
	if new_weight_kg > 0.0 and new_weight_kg != weight_kg:
		_weight_history_kg.append(weight_kg)
		weight_kg = new_weight_kg


func _add_diet(new_diet: Diet) -> void:
	if new_diet != current_diet:
		_submitted_diets_history.append(current_diet)
		current_diet = new_diet
