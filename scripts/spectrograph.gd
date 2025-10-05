extends Control

var lines = []
var line_spacing = 10

var speed = 5
var pause = false

var window = Vector2(1920, 1080)
var new_y

var is_abnormality = false

func _process(_delta: float) -> void:
	if not is_abnormality:	
		new_y = window.y/2 + randf_range(-200, 200) 
		lines.append({"x": window.x, "y": new_y})
	else:
		var direction = randf_range(-1, 1)
		new_y = window.y/ 2 + randf_range(0, 75) * direction
		lines.append({"x": window.x, "y": new_y})
	
	for line in lines:
		line["x"] -= speed
		
	lines = lines.filter(func(l): return l["x"] >= 0)
	
	queue_redraw()

func _draw():
	draw_line(Vector2(0, window.y/2), Vector2(window.x, window.y/2), Color.WHITE, 4)
	
	for line in lines:
		draw_line(Vector2(line["x"], window.y/2), Vector2(line["x"], line["y"]), Color.CYAN, 2)


func _on_play_pause_pressed() -> void:
	pause = !pause
	if pause:
		speed = 0
		
	else:
		speed = 5
		

func _on_successive_abnormality_timeout() -> void:
	is_abnormality = true
	$abnormality.start()

func _on_abnormality_timeout() -> void:
	is_abnormality = false
	$successiveAbnormality.start()
	
func _on_scan_pressed() -> void:
	if is_abnormality:
		$Label.text = "Abnormality detected"
		speed = 0
		await get_tree().create_timer(3).timeout
