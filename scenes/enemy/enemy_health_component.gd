extends HealthComponent

func damage(params: Damage) -> void:
	super(params)

func die() -> void:
	EventBus.enemy_died.emit(get_parent())
	super()
