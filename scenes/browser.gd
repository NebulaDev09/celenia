extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.color = Color(0,0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $TextEdit.text == "":
		$ColorRect.color = Color(0,0,0,1)
	else:
		$ColorRect.color = Color(0,0,0,0)
	if Input.is_action_just_pressed("enter"):
		$ColorRect.color = Color(0,0,0,0)
		$TextEdit.text = ""
		$TextEdit.editable = false
		$browser.texture = preload("res://assets/no_results.png")
	elif Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/player.tscn")
