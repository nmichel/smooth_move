class_name ExplosionParticlesEffect extends GPUParticles2D

const PARTICLE_EXPLOSION_SCENE = preload("res://effects/explosion_particles_effect.tscn")

static func create(pos: Vector2) -> ExplosionParticlesEffect:
	var effect: GPUParticles2D = PARTICLE_EXPLOSION_SCENE.instantiate()
	effect.position = pos
	effect.emitting = true
	effect.finished.connect(effect.queue_free)
	return effect
