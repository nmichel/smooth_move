class_name HealthBar extends Node2D

@export var offset: Vector2

@onready var progress_bar: ProgressBar = $ProgressBar

func _process(delta: float) -> void:
	global_position = get_parent().global_position + offset
	global_rotation = 0

func set_value(percent: float) -> void:
	progress_bar.value = progress_bar.min_value + (progress_bar.max_value - progress_bar.min_value) * percent
