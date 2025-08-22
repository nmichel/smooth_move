class_name HealthBar extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar

func set_value(percent: float) -> void:
	progress_bar.value = progress_bar.min_value + (progress_bar.max_value - progress_bar.min_value) * percent
