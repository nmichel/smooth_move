extends CanvasLayer
class_name HUD

var score: int = 0

func _ready() -> void:
	GameState.score_changed.connect(_on_score_changed)
	GameState.enemy_died.connect(_on_enemy_died)

func _on_score_changed(value: int) -> void:
	score += value
	$Score.text = str(score)

func _on_enemy_died(enemy: Enemy) -> void:
	pass
