extends Node2D

static var builder_map: Array[Callable] = [
	MobBuilder.build_tri,
	MobBuilder.build_quad,
	MobBuilder.build_deca,
]

func _ready() -> void:
	$SpawnMobTimer.start()

func spawn_bullet(position: Vector2, angle: float) -> void:
	add_child(Bullet.create(position, angle))

func _on_spawn_mob_timer_timeout() -> void:
	var size: Vector2 = get_viewport_rect().size
	var pos: Vector2 = Vector2(randf_range(50, size.x - 50), 20)
	var idx: int = randi() % builder_map.size()
	var power: int = randi() % 4
	var mob: Entity = builder_map[idx].call(pos, power)
	add_child(mob)
	
