extends Node2D
class_name Bullet

const BULLET_SCENE: PackedScene = preload("res://scenes/bullet/bullet.tscn")

var speed_direction: Vector2;

static func create(pos: Vector2, angle: float) -> Bullet:
	var bullet: Bullet = BULLET_SCENE.instantiate()
	bullet.position = pos
	bullet.global_rotation = angle
	return bullet

func _ready() -> void:
	speed_direction = Vector2(cos(global_rotation), sin(global_rotation))

	$Polygon2D.polygon = $HitboxComponent/CollisionPolygon2D2.polygon
	$Polygon2D.color = Color.YELLOW

func _process(delta: float) -> void:
	position += speed_direction * 200 * delta

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack: HitboxComponent.Attack = HitboxComponent.Attack.new()
		attack.amount = 5
		area.damage(attack)
