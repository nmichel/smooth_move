extends Node2D

const LINEAR_SPEED_PER_SECOND: float = 1000;

var angular_direction: float = 0.0
var angular_speed: float = PI / 2.0 * 4
var angle: float = -PI / 2
var linear_speed: float = 0.0
var speed_direction: Vector2 = Vector2(cos(angle), sin(angle))

var is_shooting: bool = false
var next_shoot_wait: float
@export var shoot_freq: float = 1.0

@onready var polygon: Polygon2D = $LocalFrame/Polygon2D

func _ready() -> void:
	$LocalFrame/Polygon2D.polygon = $LocalFrame/CollisionPolygon2D.polygon
	$LocalFrame/Polygon2D.color = Color.WEB_PURPLE
	get_window().focus_exited.connect(func () -> void: is_shooting = false)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().current_scene.spawn_bullet(position, angle)
		is_shooting = true
		next_shoot_wait = shoot_freq
	elif Input.is_action_just_released("ui_accept"):
		is_shooting = false

func _process(delta: float) -> void:
	angular_direction = 0.0

	if is_shooting:
		if next_shoot_wait < 0:
			get_tree().current_scene.spawn_bullet(position, angle)
			next_shoot_wait += shoot_freq
		else:
			next_shoot_wait -= delta

	if Input.is_action_pressed("ui_left"):
		angular_direction = -1.0
	
	if Input.is_action_pressed("ui_right"):
		angular_direction = 1.0
	
	if Input.is_action_pressed("ui_up"):
		linear_speed += LINEAR_SPEED_PER_SECOND * delta
	elif Input.is_action_pressed("ui_down"):
		linear_speed -= LINEAR_SPEED_PER_SECOND * delta
	else:
		var speed_sign: float = signf(linear_speed)
		linear_speed += -speed_sign * LINEAR_SPEED_PER_SECOND * delta

	angle += angular_direction * angular_speed * delta
	if angle > 2.0 * PI:
		angle -= PI * 2.0

	speed_direction = Vector2(cos(angle), sin(angle))

	$LocalFrame.global_rotation = angle
	position += speed_direction * linear_speed * delta

func _on_local_frame_area_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	create_tween().bind_node(self).tween_method(set_shader_blink_intensity, 1.0, 0, 0.2)
	$"..".start_shake_camera()

func set_shader_blink_intensity(value: float) -> void:
	var shader_material: ShaderMaterial = $LocalFrame/Polygon2D.material as ShaderMaterial
	shader_material.set_shader_parameter("blink_intensity", value)
