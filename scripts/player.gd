extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_blockScreen()
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _blockScreen():
	var overlay = ColorRect.new()
	overlay.color = Color(0,0,0,1)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	await get_tree().create_timer(1).timeout
	overlay.queue_free()

func _on_browser_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/browser.tscn")
	

func _on_locked_folder_pressed() -> void:
	print("pressed")
	var popup_instance = preload("res://scenes/popup.tscn")
	var popup = popup_instance.instantiate()
	#popup.placeholder = "Enter password"
	$GridContainer.add_child(popup)
	


func _on_trash_pressed() -> void:
	var emptyRecylce_instance = preload("res://scenes/empty_recycle.tscn")
	var emptyRecycle = emptyRecylce_instance.instantiate()
	$GridContainer.add_child(emptyRecycle)


func _on_cd_pressed() -> void:
	var filesystemInstance = preload("res://file_system.gd")
	var fileSystem = filesystemInstance.instantiate()
	fileSystem.text = ["", "", "", "", ""]
	$GridContainer.add_child(fileSystem)

func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/transcription.tscn")
	 
