class_name PlanejamentoAlimentarDietHistoryContainer
extends Control


@export var diet_history_container: Container
@export var no_diet_history_container: Container


func _ready() -> void:
	no_diet_history_container.show()
	diet_history_container.hide()


func show_history() -> void:
	diet_history_container.show()
	no_diet_history_container.hide()


func hide_history() -> void:
	diet_history_container.hide()
	no_diet_history_container.show()
