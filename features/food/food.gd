class_name Food
extends Resource


enum FoodCompositionDatabase {
	NULL,
	TUCUNDUVA,
	TBCA,
	USDA,
	CUSTOM_RECIPE
}


@export var name: String
@export var texture: CompressedTexture2D
@export var composition_database: FoodCompositionDatabase = FoodCompositionDatabase.NULL
@export_multiline var description: String

@export_group("Composition Data")
@export var composition: Dictionary[String, float] = {
	"CHO": 0.0,
	"PTN": 0.0,
	"LIP": 0.0,
	"fibers": 0.0,
}


func get_energy() -> float:
	var energy_sum: float = 0.0
	
	for nutrient_name: String in composition.keys():
		if nutrient_name in ["CHO", "PTN"]:
			energy_sum += composition[nutrient_name] * 4.0
		
		elif nutrient_name == "LIP":
			energy_sum += composition[nutrient_name] * 9.0
	
	return energy_sum


func get_energy_from_weight(weight_g: float) -> float:
	return get_energy() * (weight_g / 100.0)
