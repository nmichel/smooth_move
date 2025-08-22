extends Node2D

static var builder_map: Array[Callable] = [
	MobBuilder.build_tri,
	MobBuilder.build_quad,
	MobBuilder.build_deca,
]

@onready var camera2D: Camera2D = $Camera2D
@onready var cameraShake: FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	AudioManager.play_track(AudioManager.get_track_list()[0])
	$SpawnMobTimer.start()

func spawn_bullet(pos: Vector2, angle: float) -> void:
	add_child(Bullet.create(pos, angle))

func spawn_bullet_explosion(pos: Vector2) -> void:
	add_child(ExplosionParticlesEffect.create(pos))

func start_shake_camera() -> void:
	create_tween().tween_method(shake_camera, 10.0, 1.0, 0.5)

func shake_camera(intensity: float) -> void:
	var camera_offset: float = cameraShake.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera2D.offset.x = camera_offset
	camera2D.offset.y = camera_offset

func _on_spawn_mob_timer_timeout() -> void:
	var size: Vector2 = get_viewport_rect().size
	var pos: Vector2 = Vector2(randf_range(50, size.x - 50), 20)
	var idx: int = randi() % builder_map.size()
	var power: int = randi() % 4
	var mob: Entity = builder_map[idx].call(pos, power)
	add_child(mob)
	
