class_name HitNoteEffect
extends Node2D

@export var duration: float = 1
@export var rise_amount: float = 40.0

var elapsed := 0.0
var start_position: Vector2
var text: String
var direction: Vector2

const SCENE = preload("res://effects/hit_note_effect/hit_note_effect.tscn")

static func create(pos: Vector2, value: int) -> Node:
	var effect: HitNoteEffect = SCENE.instantiate()
	effect.start_position = pos
	effect.text = str(value)
	return effect

func _ready() -> void:
	$Label.text = text
	position = start_position
	direction = _random_direction()

func _process(delta: float) -> void:
	elapsed += delta
	position = start_position + (direction * rise_amount * (elapsed / duration))
	modulate.a = cos(elapsed / duration * PI/2)
	if elapsed >= duration:
		queue_free()

func _random_direction() -> Vector2:
	var angle: float = randf() * PI * 2.0
	return Vector2.from_angle(angle)
