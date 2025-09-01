extends Node

@onready var game: Game = get_tree().get_first_node_in_group("game")

func _ready() -> void:
	EventBus.enemy_died.connect(_on_enemy_died)
	EventBus.enemy_hit.connect(_on_enemy_hit)
	
func _on_enemy_died(enemy: Enemy) -> void:
	game.add_child(ExplosionParticlesEffect.create(enemy.position, enemy.color))
	game.add_child(DeathNoteEffect.create(enemy.position, int(enemy.scale_factor)))

	# To move out
	GameState.add_to_score(int(enemy.scale_factor))

func _on_enemy_hit(enemy: Enemy, results: Dictionary) -> void:
	if ! results.is_empty():
		game.add_child(BeamParticleEffect.create(results.position, results.normal))
		game.add_child(HitNoteEffect.create(results.position, -1))
