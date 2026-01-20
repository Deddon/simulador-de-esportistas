class_name Sportsman
extends Resource


const DEFAULT_HEIGHT_CM := 180
const DEFAULT_AGE_YEARS := 24

const DEFAULT_TRAINING_WEEK_FREQUENCY := 5
const DEFAULT_TRAINING_DURATION_MIN := 40
const DEFAULT_AVERAGE_TRAINING_MINUTES_DAY := (DEFAULT_TRAINING_WEEK_FREQUENCY * DEFAULT_TRAINING_DURATION_MIN) / 7.0


@export var name: String
@export var weight_kg: float = 60.0
@export var current_sport: Constants.SportsmanAvailableSports = Constants.SportsmanAvailableSports.NULL
@export var base_needs_guideline: NutrientGuideline


func calculate_energy() -> float:
	var MBR: float = harris_benedict()
	var MET: float = met_expenditure()
	return MBR + MET


func harris_benedict() -> float:
	return 66.47 + (13.75 * weight_kg) + (5.003 * DEFAULT_HEIGHT_CM) - (6.775 * DEFAULT_AGE_YEARS)


func met_expenditure() -> float:
	var calories_per_minute: float
	calories_per_minute = (Constants.AvailableSportsMet[current_sport] * 3.5 * weight_kg) / 200
	return calories_per_minute * DEFAULT_AVERAGE_TRAINING_MINUTES_DAY
