extends Node

class_name HealthComponent

class Damage:
	var amount: int = 0

@export var MAX_HEALTH: int = 10
var health: int

func _ready() -> void:
	health = MAX_HEALTH

func damage(params: Damage) -> void:
	health -= params.amount
	if health <= 0:
		die()

func die() -> void:
	get_parent().queue_free()
