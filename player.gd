extends Area2D

const LINEAR_SPEED_PER_SECOND: float = 1000;

var angular_direction: float = 0.0
var angular_speed: float = PI / 2.0 * 4
var angle: float = 0.0
var linear_speed: float = 0.0
var speed_direction: Vector2 = Vector2(cos(angle), sin(angle))
	
func _input(event: InputEvent) -> void:
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
		var sign: float = signf(linear_speed)
		linear_speed += -sign * LINEAR_SPEED_PER_SECOND * delta

	angle += angular_direction * angular_speed * delta
	if angle > 2.0 * PI:
		angle -= PI * 2.0

	speed_direction = Vector2(cos(angle), sin(angle))

	global_rotation = angle
	position += speed_direction * linear_speed * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("player collision")
	linear_speed = 0
