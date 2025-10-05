extends Control

func addMessage(text, _name):
	var message_instance = preload("res://scenes/message.tscn")
	var message = message_instance.instantiate()
	$ScrollContainer/VScrollBar.add_child(message)
	message.write(text)
	message.add_name(_name)
	
func _ready():
	addMessage("hello", "tejas")
	addMessage("hello", "tejas")
	addMessage("hello", "tejas")
	addMessage("hello", "tejas")
	addMessage("hello", "tejas")
	addMessage("hello", "tejas")
