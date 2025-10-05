extends Control

@onready var doc_text = $transcript
@onready var type_timer: Timer = $Timer

var full_text: String = ""
var visible_chars: int = 0
var overlay = ColorRect.new()

var translation = {
	'mudachi' : 'evil person',
	'durak': 'fool',
	'ponyatno': 'got it'
}

func _ready():
	
	full_text = """

A subtle shiver quickly asserts its place along your spine, for you know you've just doomed a family of (at the very least) three individuals to being separated, be that by thanks to jailing or by death. Under this government, you're not sure if there's much of a difference. But had you attempted to save them, it's entirely possible that the officials would've come after you, and more importantly, your family. But since that'd never happened before, you had no reason to believe so, except your own paranoia. You take a deep breath in an attempt to steel yourself to continue with your work. [End of content]
"""
	
	doc_text.text = ""  
	visible_chars = 0
	doc_text.wrap_mode = true       
	doc_text.scroll_vertical = true
	doc_text.scroll_horizontal = false  
	
	type_timer.start()
	block_input()
	
func _process(delta: float) -> void:
	var selected = doc_text.get_selected_text()
	selected.strip_edges()
	for i in translation:
		if selected == i:
			var selection_start_line = doc_text.get_selection_from_line()
			var selection_start_column = doc_text.get_selection_from_column()
			var selection_end_line = doc_text.get_selection_to_line()
			var selection_end_column = doc_text.get_selection_to_column()
			doc_text.insert_text(translation[i],selection_start_line,selection_start_column)

func _on_timer_timeout() -> void:
	if visible_chars < full_text.length():
		visible_chars += 1
		doc_text.text = full_text.substr(0, visible_chars)
		doc_text.scroll_vertical = doc_text.get_line_count()
	else:
		overlay.queue_free()
		type_timer.stop()
	
func block_input():
	overlay.color = Color(0,0,0,0)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
