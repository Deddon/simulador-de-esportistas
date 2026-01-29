extends Node


@export var foods_path: String = "res://shared/resources/foods/"
@export var sportsmen_path: String = "res://shared/resources/sportsman/"
@export var sports_events_path: String = "res://shared/resources/sports_event/"
@export var guidelines_path: String = "res://shared/resources/nutrient_guideline/"

var _foods_buffered: Array[Food]
var _sportsmen_buffered: Array[Sportsman]
var _events_buffered: Dictionary[String, SportsEvent]
var _guidelines_buffered: Dictionary[String, NutrientGuideline]


func load_all_foods(load_from_cache: bool = true) -> Array[Food]:
	if load_from_cache and _foods_buffered:
		return _foods_buffered
	
	var resources_names: PackedStringArray = DirAccess.get_files_at(foods_path)
	for res_name: String in resources_names:
		_foods_buffered.append(load(foods_path.path_join(res_name)))
	
	return _foods_buffered


func load_all_sportsmen(load_from_cache: bool = true) -> Array[Sportsman]:
	if load_from_cache and _sportsmen_buffered:
		return _sportsmen_buffered
	
	var resources_names: PackedStringArray = DirAccess.get_files_at(sportsmen_path)
	for res_name: String in resources_names:
		_sportsmen_buffered.append(load(sportsmen_path.path_join(res_name)))
	
	return _sportsmen_buffered


func load_event_from_name(event_name: String, update_cache: bool = false) -> SportsEvent:
	if update_cache:
		var resources_names: PackedStringArray = DirAccess.get_files_at(sports_events_path)
		for res_name: String in resources_names:
			var event: SportsEvent = load(sports_events_path.path_join(res_name))
			_events_buffered[event.name] = event
	
	var matching_event: SportsEvent = _events_buffered.get(event_name)
	return matching_event


func load_guideline_from_name(guideline_name: String, update_cache: bool = false) -> NutrientGuideline:
	if update_cache:
		var resources_names: PackedStringArray = DirAccess.get_files_at(guidelines_path)
		for res_name: String in resources_names:
			var guideline: NutrientGuideline = load(guidelines_path.path_join(res_name))
			_guidelines_buffered[guideline.name] = guideline
	
	var matching_guideline: NutrientGuideline = _guidelines_buffered.get(guideline_name)
	return matching_guideline
