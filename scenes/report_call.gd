extends TextureRect

@onready var yes_button = $Button
@onready var no_button = $Button2

signal yes_clicked(yes)
signal no_clicked(no)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("yes_clicked")


func _on_button_2_pressed() -> void:
	emit_signal("no_clicked")
