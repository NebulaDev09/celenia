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

You take a deep breath as fear takes a hold on you, snaring you, as you attempt to continue your work. The thought of having possibly helped a stranger at the expense of your own being and your family's wreaks havoc in your mind, but comes with a morbid sense of gladness, which you let guide you as you move forth. [End of Content]

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
	
