class_name DeathNoteEffect extends Node2D

@export var duration: float = 0.5
@export var rise_amount: float = 40.0

var elapsed := 0.0
var start_position: Vector2
var scale_factor: float
var text: String

const SCENE = preload("res://effects/death_note_effect/death_note_effect.tscn")

static func create(pos: Vector2, value: int) -> Node:
	var effect: DeathNoteEffect = SCENE.instantiate()
	effect.start_position = pos
	effect.text = str(value)
	effect.scale_factor = min(1 + value * 0.02, 3)
	return effect

func _ready() -> void:
	$Label.text = text
	position = start_position
	scale = Vector2(scale_factor, scale_factor)

func _process(delta: float) -> void:
	elapsed += delta
	position.y = start_position.y - (rise_amount * (elapsed / duration))
	modulate.a = cos(elapsed / duration * PI/2)
	if elapsed >= duration:
		queue_free()
