extends Area2D
class_name HitboxComponent

class Attack:
	var amount: int

@export var health_component: HealthComponent

func damage(attack: Attack) -> void:
	if health_component:
		var damage: HealthComponent.Damage = HealthComponent.Damage.new()
		damage.amount = attack.amount
		health_component.damage(damage)
