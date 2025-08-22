extends Node2D

const LINEAR_SPEED_PER_SECOND: float = 1000;

var angular_direction: float = 0.0
var angular_speed: float = PI / 2.0 * 4
var angle: float = 0.0
var linear_speed: float = 0.0
var speed_direction: Vector2 = Vector2(cos(angle), sin(angle))

@onready var polygon: Polygon2D = $LocalFrame/Polygon2D

func _ready() -> void:
	$LocalFrame/Polygon2D.polygon = $LocalFrame/CollisionPolygon2D.polygon
	$LocalFrame/Polygon2D.color = Color.WEB_PURPLE

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().root.get_node("Game").spawn_bullet(position, angle)

func _process(delta: float) -> void:
	angular_direction = 0.0

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
