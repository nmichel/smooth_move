class_name ExplosionParticlesEffect extends GPUParticles2D

const SCENE = preload("res://effects/particle_explosion_effect/particle_explosion_effect.tscn")

static func create(pos: Vector2, color: Color) -> ExplosionParticlesEffect:
	var effect: GPUParticles2D = SCENE.instantiate()
	effect.position = pos
	effect.emitting = true
	effect.finished.connect(effect.queue_free)
	(effect.process_material as ParticleProcessMaterial).color = color
	return effect
