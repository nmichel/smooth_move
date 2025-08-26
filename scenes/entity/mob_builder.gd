class_name MobBuilder extends Node

static var TRI_SHAPE: PackedVector2Array = build_shape(3)
static var QUAD_SHAPE: PackedVector2Array = build_shape(4)
static var PENTA_SHAPE: PackedVector2Array = build_shape(5)
static var HEXA_SHAPE: PackedVector2Array = build_shape(6)
static var HEPTA_SHAPE: PackedVector2Array = build_shape(7)
static var OCTO_SHAPE: PackedVector2Array = build_shape(8)
static var ENNEA_SHAPE: PackedVector2Array = build_shape(9)
static var DECA_SHAPE: PackedVector2Array = build_shape(10)

static var MOB_FACTORIES: Array[Callable] = [
	func (pos: Vector2, power: int) -> Entity: return build_entity(TRI_SHAPE, pos, power, Color.YELLOW),
	func (pos: Vector2, power: int) -> Entity: return build_entity(QUAD_SHAPE, pos, power, Color.BLUE),
	func (pos: Vector2, power: int) -> Entity: return build_entity(PENTA_SHAPE, pos, power, Color.WEB_GREEN),
	func (pos: Vector2, power: int) -> Entity: return build_entity(HEXA_SHAPE, pos, power, Color.CRIMSON),
	func (pos: Vector2, power: int) -> Entity: return build_entity(HEPTA_SHAPE, pos, power, Color.BLUE_VIOLET),
	func (pos: Vector2, power: int) -> Entity: return build_entity(OCTO_SHAPE, pos, power, Color.CORAL),	
	func (pos: Vector2, power: int) -> Entity: return build_entity(ENNEA_SHAPE, pos, power, Color.AQUA),	
	func (pos: Vector2, power: int) -> Entity: return build_entity(DECA_SHAPE, pos, power, Color.CADET_BLUE),	
]

static func max_entity_id() -> int:
	return MOB_FACTORIES.size()

static func spawn_entity(idx: int, position: Vector2, power: int) -> Entity:
	return MOB_FACTORIES[idx].call(position, power)

static func build_shape(faces: int) -> PackedVector2Array:
	assert(faces > 2, "At least 3 faces required")

	var step: float = 2.0 * PI / faces
	var res: PackedVector2Array = PackedVector2Array()
	for i in range(0, faces):
		var angle: float = step * i
		res.append(Vector2(cos(angle), sin(angle)))
	return res

static func build_entity(shape: PackedVector2Array, pos: Vector2, power: int, color: Color) -> Entity:
	var entity: Entity = Entity.create(shape, pos, power * 10)
	entity.color = color
	return entity
