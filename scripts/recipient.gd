extends Control

@onready var doc_text: RichTextLabel = $recipient
@onready var type_timer: Timer = $Timer

var full_text: String = ""
var visible_chars: int = 0
var typing_speed := 0.02

func _ready():
	type_timer.wait_time = typing_speed
	type_timer.connect("timeout", Callable(self, "_on_type_timer_timeout"))
	
	full_text = """[b]CONFIDENTIAL[/b]

Subject: Project SILO
Date: 2004-07-19

This document is classified.
Unauthorized viewing will be logged."""
	
	doc_text.bbcode_enabled = true
	doc_text.text = "" 
	visible_chars = 0
	
	type_timer.start()

func _on_type_timer_timeout():
	if visible_chars < full_text.length():
		visible_chars += 1
		doc_text.text = full_text.substr(0, visible_chars)
	else:
		type_timer.stop()
