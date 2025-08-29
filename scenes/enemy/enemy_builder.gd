extends Object

class_name EnemyBuilder


static func max_enemy_id() -> int:
	return MOB_FACTORIES.size()

static func spawn_enemy(idx: int, position: Vector2, power: int) -> Enemy:
	return MOB_FACTORIES[idx].call(position, power)

static var cache: Dictionary[Vector2i, PackedVector2Array] = {}

static var MOB_FACTORIES: Array[Callable] = [
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(3, pos, power, Color.YELLOW),
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(4, pos, power, Color.BLUE),
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(5, pos, power, Color.WEB_GREEN),
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(6, pos, power, Color.CRIMSON),
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(7, pos, power, Color.BLUE_VIOLET),
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(8, pos, power, Color.CORAL),	
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(9, pos, power, Color.AQUA),	
	func (pos: Vector2, power: int) -> Enemy: return _build_enemy(10, pos, power, Color.CADET_BLUE),	
]

static func _build_enemy(size: int, pos: Vector2, power: int, color: Color) -> Enemy:
	var shape: PackedVector2Array = _get_shape(size, power * 10)
	var enemy: Enemy = Enemy.create(shape, pos, power * 10)
	enemy.color = color
	return enemy

static func _get_shape(faces: int, radius: int) -> PackedVector2Array:
	assert(faces > 2, "At least 3 faces required")

	var key: Vector2i = Vector2i(faces, radius)
	
	# Cache lookup
	if cache.has(key):
		return cache.get(key)

	# Create requested and add in cache and tree
	var step: float = 2.0 * PI / faces
	var res: PackedVector2Array = PackedVector2Array()
	for i in range(0, faces):
		var angle: float = step * i
		res.append(Vector2(cos(angle) * radius, sin(angle) * radius))
	
	cache.set(key, res)
	
	return res
