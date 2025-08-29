extends VisibleOnScreenNotifier2D

class_name OutOfScreenComponent

func _on_screen_exited() -> void:
	get_parent().queue_free()
