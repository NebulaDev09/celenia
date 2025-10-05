extends Control

var text = ""
var editable = false
var placeholder = ""

func _process(delta: float) -> void:
	$TextEdit.text = text 
	$TextEdit.editable = editable
	$TextEdit.placeholder_text = placeholder
	
