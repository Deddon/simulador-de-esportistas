extends Node


var player_data: PackedStringArray
var _buffered_sportsmen: Array[Sportsman]


func add_sportsman(sportsman: Sportsman) -> void:
	_buffered_sportsmen.append(sportsman)


func get_all_sportsmen() -> Array[Sportsman]:
	return _buffered_sportsmen


func get_sportsman_from_name(sportsman_name: String) -> Sportsman:
	var selected_sportsman: Sportsman
	
	for s: Sportsman in _buffered_sportsmen:
		if s.name == sportsman_name:
			selected_sportsman = s
	
	return selected_sportsman
