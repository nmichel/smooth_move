extends Node

class_name HealthComponent

class Damage:
	var amount: int = 0

@export var MAX_HEALTH: int = 10
var health: int

func _ready() -> void:
	health = MAX_HEALTH

func damage(damage: Damage) -> void:
	health -= damage.amount
	if health <= 0:
		get_parent().queue_free()

	
