extends Polygon2D

func _ready() -> void:
	var size: Vector2 = get_viewport_rect().size
	set_polygon(PackedVector2Array([
		Vector2(0, 0),
		Vector2(size.x, 0),
		Vector2(size.x, size.y),
		Vector2(0, size.y),
	]))
