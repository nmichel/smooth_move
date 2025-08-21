class_name Entity extends Area2D

const ENTITY_SCENE: PackedScene = preload("res://entity.tscn")

var angle: float = randf_range(0, 2 * PI)
var angular_speed: float = randf_range(0, 1)
var color: Color = Color.WHITE

static func create(shape: PackedVector2Array, pos: Vector2, scale_factor: float) -> Entity:
	var entity: Entity = ENTITY_SCENE.instantiate()
	var collision_polygon: CollisionPolygon2D = entity.get_child(0)
	collision_polygon.polygon = shape
	entity.position = pos
	entity.scale = Vector2(scale_factor, scale_factor)
	return entity

func _ready() -> void:
	$Polygon2D.polygon = $CollisionPolygon2D.polygon
	$Polygon2D.color = color
	global_rotation += angular_speed

func _process(delta: float) -> void:
	position += Vector2(0, 1) * 100 * delta
	angle += 2 * PI * angular_speed * delta
	if angle > 2.0 * PI:
		angle -= PI * 2.0
	global_rotation = angle

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	pass
