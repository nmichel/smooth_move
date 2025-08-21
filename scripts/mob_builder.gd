class_name MobBuilder extends Node

static var TRI_SHAPE: PackedVector2Array = build_shape(3)
static var QUAD_SHAPE: PackedVector2Array = build_shape(4)
static var PENTA_SHAPE: PackedVector2Array = build_shape(5)
static var HEXA_SHAPE: PackedVector2Array = build_shape(6)
static var HEPTA_SHAPE: PackedVector2Array = build_shape(7)
static var OCTO_SHAPE: PackedVector2Array = build_shape(8)
static var ENNEA_SHAPE: PackedVector2Array = build_shape(9)
static var DECA_SHAPE: PackedVector2Array = build_shape(10)

static func build_shape(faces: int) -> PackedVector2Array:
	assert(faces > 2, "At least 3 faces required")

	var step: float = 2.0 * PI / faces
	var res: PackedVector2Array = PackedVector2Array()
	for i in range(0, faces):
		var angle: float = step * i
		res.append(Vector2(cos(angle), sin(angle)))
		
	return res

static func build_tri(pos: Vector2, power: int) -> Entity:
	var entity: Entity = Entity.create(TRI_SHAPE, pos, power * 10)
	entity.color = Color.YELLOW
	return entity

static func build_quad(pos: Vector2, power: int) -> Entity:
	var entity: Entity = Entity.create(QUAD_SHAPE, pos, power * 10)
	entity.color = Color.BLUE
	return entity

static func build_deca(pos: Vector2, power: int) -> Entity:
	var entity: Entity = Entity.create(DECA_SHAPE, pos, power * 10)
	entity.color = Color.CADET_BLUE
	return entity
