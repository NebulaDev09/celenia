extends Control

var text = []
@onready var labels = [$Label, $Label2, $Label3, $Label4, $Label5]

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func addText(l):
	text = l
	for i in range(1,5):
		labels[i].text = text[i]
