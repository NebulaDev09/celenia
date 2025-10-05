extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_blockScreen()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _blockScreen():
	var overlay = ColorRect.new()
	overlay.color = Color(0,0,0,1)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	await get_tree().create_timer(1).timeout
	overlay.queue_free()
