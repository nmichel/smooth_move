class_name BeamParticleEffect extends GPUParticles2D

const BEAM_PARTICUES_SCENE = preload("res://effects/particle_beam_effect.tscn")

static func create(pos: Vector2, dir: Vector2) -> BeamParticleEffect:
	var effect: GPUParticles2D = BEAM_PARTICUES_SCENE.instantiate()
	effect.position = pos
	effect.emitting = true
	effect.finished.connect(effect.queue_free)
	var mat: ParticleProcessMaterial = effect.process_material
	mat.direction = Vector3(dir.x, dir.y, 0)
	return effect
