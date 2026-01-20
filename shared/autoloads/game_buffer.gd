extends Node


var player_name: String = ""
var _buffered_diet: Diet
var _buffered_sportsman: Sportsman


func add_diet(diet: Diet) -> void:
	_buffered_diet = diet


func get_buffered_diet() -> Diet:
	return _buffered_diet


func add_sportsman(sportsman: Sportsman) -> void:
	_buffered_sportsman = sportsman


func get_buffered_sportsman() -> Sportsman:
	return _buffered_sportsman
