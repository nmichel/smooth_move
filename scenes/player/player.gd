extends Node2D

enum Flags {
	FLAG_LEFT = 0b1000,
	FLAG_RIGHT = 0b0100,
	FLAG_UP = 0b0010,
	FLAG_DOWN = 0b0001,
	FLAG_ALL = 0b1111
}

var moving_flags: int = 0

var angle: float = -PI / 2
@export var linear_speed: float = 0.0

var is_shooting: bool = false
var next_shoot_wait: float
@export var shoot_freq: float = 1.0

@onready var polygon: Polygon2D = $LocalFrame/Polygon2D

func _ready() -> void:
	$LocalFrame/Polygon2D.polygon = $LocalFrame/CollisionPolygon2D.polygon
	$LocalFrame/Polygon2D.color = Color.WEB_PURPLE
	get_window().focus_exited.connect(func () -> void:
		is_shooting = false
		moving_flags = 0
		)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().current_scene.spawn_bullet(position, angle)
		is_shooting = true
		next_shoot_wait = shoot_freq
	elif Input.is_action_just_released("ui_accept"):
		is_shooting = false

	if Input.is_action_just_pressed("ui_left"):
		moving_flags |= Flags.FLAG_LEFT
	elif Input.is_action_just_pressed("ui_right"):
		moving_flags |= Flags.FLAG_RIGHT
		
	if Input.is_action_just_pressed("ui_up"):
		moving_flags |= Flags.FLAG_UP
	elif Input.is_action_just_pressed("ui_down"):
		moving_flags |= Flags.FLAG_DOWN

	if Input.is_action_just_released("ui_left"):
		moving_flags &= (Flags.FLAG_LEFT ^ Flags.FLAG_ALL)
	elif Input.is_action_just_released("ui_right"):
		moving_flags &= (Flags.FLAG_RIGHT ^ Flags.FLAG_ALL)
		
	if Input.is_action_just_released("ui_up"):
		moving_flags &= (Flags.FLAG_UP ^ Flags.FLAG_ALL)
	elif Input.is_action_just_released("ui_down"):
		moving_flags &= (Flags.FLAG_DOWN ^ Flags.FLAG_ALL)

func _process(delta: float) -> void:
	if is_shooting:
		if next_shoot_wait < 0:
			get_tree().current_scene.spawn_bullet(position, angle)
			next_shoot_wait += shoot_freq
		else:
			next_shoot_wait -= delta

	if moving_flags != 0:
		var unit_direction: Vector2 = direction_vector_from_moving_flags()
		position += unit_direction * linear_speed * delta

func _on_local_frame_area_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	create_tween().bind_node(self).tween_method(set_shader_blink_intensity, 1.0, 0, 0.2)
	$"..".start_shake_camera()

func set_shader_blink_intensity(value: float) -> void:
	var shader_material: ShaderMaterial = $LocalFrame/Polygon2D.material as ShaderMaterial
	shader_material.set_shader_parameter("blink_intensity", value)

func direction_vector_from_moving_flags() -> Vector2:
	var direction: Vector2 = Vector2(0, 0)

	if moving_flags & Flags.FLAG_LEFT:
		direction += Vector2(-1, 0)
	if moving_flags & Flags.FLAG_RIGHT:
		direction += Vector2(1, 0)
	if moving_flags & Flags.FLAG_UP:
		direction += Vector2(0, -1)
	if moving_flags & Flags.FLAG_DOWN:
		direction += Vector2(0, 1)
		
	return direction.normalized()
