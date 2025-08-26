class_name Entity extends Node2D

const ENTITY_SCENE: PackedScene = preload("res://scenes/entity.tscn")

@onready var health_bar: HealthBar = $HealthBar

var max_health: float
var health: float
var scale_factor: float
var shape: PackedVector2Array
var angle: float = randf_range(0, 2 * PI)
var angular_speed: float = randf_range(0, 1)
var color: Color = Color.WHITE

static func create(shape_in: PackedVector2Array, pos: Vector2, scale_factor_in: float) -> Entity:
	var entity: Entity = ENTITY_SCENE.instantiate()
	entity.scale_factor = scale_factor_in
	entity.shape = shape_in
	entity.position = pos
	entity.max_health = scale_factor_in
	return entity

func _ready() -> void:
	$LocalFrame.scale = Vector2(scale_factor, scale_factor)
	$LocalFrame.global_rotation += angular_speed
	$LocalFrame/CollisionPolygon2D.polygon = shape
	$LocalFrame/Polygon2D.polygon = shape
	$LocalFrame/Polygon2D.color = color

	$HealthBar.position.y = -scale_factor - 10;

	health = max_health

func _process(delta: float) -> void:
	position += Vector2(0, 1) * 100 * delta
	angle += 2 * PI * angular_speed * delta
	if angle > 2.0 * PI:
		angle -= PI * 2.0
	$LocalFrame.global_rotation = angle

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_local_frame_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	# Update state
	health -= 10
	if health <= 0:
		$"..".spawn_explosion(position, color)
		queue_free()
		
	health_bar.set_value(health / max_health)

	# Lauch VFX
	create_tween().bind_node(self).tween_method(set_shader_blink_intensity, 1.0, 0, 0.2)	
	create_tween().bind_node(self).tween_method(set_health_bar_alpha, 1.0, 0.0, 0.5)

	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	
	var params: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = false
	params.collision_mask = 8
	# "from" and "to" setup is of paramount importance here : testing ray must start outside
	# the tested entity Area2D (and so start at the position of the entering "area").
	params.from = area.global_position + (area.global_position - $LocalFrame.global_position).normalized() * scale_factor * 1.1
	params.to = $LocalFrame.global_position

	var results: Dictionary = space_state.intersect_ray(params)
	if ! results.is_empty(): 
		$"..".spawn_particle_beam(results.position, results.normal)

func set_shader_blink_intensity(value: float) -> void:
	var shader_material: ShaderMaterial = $LocalFrame/Polygon2D.material as ShaderMaterial
	shader_material.set_shader_parameter("blink_intensity", value)

func set_health_bar_alpha(value: float) -> void:
	$HealthBar.modulate.a = value
	
