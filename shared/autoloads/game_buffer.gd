extends Node


var _buffered_diet: Diet


func add_diet(diet: Diet) -> void:
	_buffered_diet = diet


func get_buffered_diet() -> Diet:
	return _buffered_diet
