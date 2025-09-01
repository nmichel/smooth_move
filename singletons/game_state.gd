extends Node

var score: int = 0

func add_to_score(points: int) -> void:
	score += points
	EventBus.emit_signal("score_changed", score)
	
