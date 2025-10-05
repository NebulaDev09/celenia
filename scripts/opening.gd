extends Control

@onready var doc_text = $RichTextLabel
@onready var type_timer = $Timer
@onready var continueTimer = $continueTimer

var text = ""
var chars = 0

func _ready():
	text = """[b]ANY[/b] content on this system under [b]NO[/b] cirumstances shall be compromised. Failiure to follow, could result in prosecution under [b]section 110[/b] and/or [b]"termination"[/b] effective immediately"""
	
	doc_text.bbcode_enabled = true
	doc_text.text = ""  # 
	chars = 0
	
	type_timer.start()


func _on_timer_timeout() -> void:
	if chars < text.length():
		chars += 1
		doc_text.text = text.substr(0, chars)
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
