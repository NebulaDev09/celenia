extends Control

@onready var doc_text = $message
@onready var type_timer = $Timer

var text = ""
var chars = 0
var typing_speed = 0.02
	
func write(s):
	text = s
	doc_text.bbcode_enabled = true
	doc_text.text = ""
	chars = 0
	type_timer.wait_time = typing_speed
	type_timer.start()

func _on_timer_timeout() -> void:
	if chars < text.length():
		chars += 1
		doc_text.text = text.substr(0, chars)
	else:
		return
		
func add_name(name):
	$name.text = name
