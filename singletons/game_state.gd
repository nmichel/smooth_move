extends Node

signal score_changed(new_score: int)
signal enemy_died(enemy: Enemy)
signal enemy_hit(enemy: Enemy, hit: Dictionary)

var score: int = 0

func add_to_score(points: int) -> void:
	score += points
	emit_signal("score_changed", score)
	
