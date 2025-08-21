class_name Bullet extends Area2D

const BULLET_SCENE: PackedScene = preload("res://bullet.tscn")

var speed_direction: Vector2;

static func create(position: Vector2, angle: float) -> Bullet:
	var bullet: Bullet = BULLET_SCENE.instantiate()
	bullet.position = position
	bullet.global_rotation = angle
	return bullet

func _ready() -> void:
	speed_direction = Vector2(cos(global_rotation), sin(global_rotation))

	var collision_geom: CollisionPolygon2D = $CollisionPolygon2D
	$Polygon2D.polygon = collision_geom.polygon
	$Polygon2D.color = Color.YELLOW

func _process(delta: float) -> void:
	position += speed_direction * 200 * delta

func _on_bullet_visibility_notifier_screen_exited() -> void:
	queue_free()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	queue_free()
