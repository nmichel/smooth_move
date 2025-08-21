extends Polygon2D

func _ready() -> void:
	var collision_geom: CollisionPolygon2D = get_parent().get_node("CollisionPolygon2D")
	self.polygon = collision_geom.polygon
	self.color = Color.RED
