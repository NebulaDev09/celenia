extends Control

@onready var doc_text = $transcript
@onready var type_timer: Timer = $Timer

var full_text: String = ""
var visible_chars: int = 0
var overlay = ColorRect.new()
var popup_reportInstance = preload("res://scenes/report_call.tscn")
var popup = popup_reportInstance.instantiate()

var translation = {
	'mudachi' : 'evil person',
	'durak': 'fool',
	'ponyatno': 'got it'
}

func _ready():
	popup.connect("yes_clicked", Callable(self, "_yes_clicked"))
	popup.connect("no_clicked", Callable(self, "_no_clicked"))
	
	full_text = """
Daniel: Harold. How's the shipment looking? It's been a helluva long time since you started working on it.

Harold: Let me work in peace, damn it. Growing Marijuana out of the back of a truck is exhausting and time consuming work, you know?

Daniel: *sigh.* How long? 

Harold: A week at best? Month at worst. Well what COULD be a lot worse is me trying too hard and getting caught. That'd be miserable.

Daniel: A WEEK? That won't do. I genuinely doubt that grandpa could survive that long, without getting admitted to a hospital. This damn government and it's inexorbitant rates for healthcare will sum doom for him if you don't speed up.

Harold: Well, if I do my work rashly and get caught, that money is NEVER gonna reach your hands, much less grandpa's. We're seemingly doomed either way.

Daniel: Might as well take the gamble, then?

Harold: ...Very well. Familia es todo. Wish me luck.

Daniel: Familia es todo. I hate that we have to put others through this, but... this is the only way grandpa lives, filthy drug money.

Harold: Well, I'd love to let you continue riding your philosophical high horse, but I fear that I have plants to grow.

Daniel: Get to it, then.

*Terminate call*

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
		$GridContainer.add_child(popup)
	
func block_input():
	overlay.color = Color(0,0,0,0)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
	
func _yes_clicked():
	get_tree().change_scene_to_file("res://scenes/transcription1.tscn")

func _no_clicked():
	get_tree().change_scene_to_file("res://scenes/transcription2.tscn")
