extends CanvasLayer
class_name HUD

var score: int = 0

func _ready() -> void:
	GameState.connect("score_changed", _on_score_changed)

func _on_score_changed(value: int) -> void:
	score += value
	$Score.text = str(score)
