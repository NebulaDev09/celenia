extends Control

@export var front_texture: Texture2D
@export var back_texture: Texture2D

signal card_clicked(card)

var revealed = false

func _ready():
	back_texture = preload("res://assets/card_matcher/card_back.png")
	$TextureRect.texture = back_texture

func reveal():
	if revealed:
		return
	revealed = true
	$TextureRect.texture = front_texture

func hide_card():
	if not revealed:
		return
	revealed = false
	$TextureRect.texture = back_texture

func _on_button_pressed() -> void:
	emit_signal("card_clicked", self)
	reveal()
	
