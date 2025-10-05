extends Control

@onready var grid = $GridContainer
var matched = 0
var pairs = 3

var first_card = null
var second_card = null

signal complete(card)

func _ready():
		setup_cards()
		
func build_deck():
	var deck = [
		preload("res://assets/card_matcher/card_alpha.png"),
		preload("res://assets/card_matcher/card_beta.png"),
		preload("res://assets/card_matcher/card_gamma.png")
	]
	var textures = []
	for i in deck:
		textures.append(i)
		textures.append(i)
	textures.shuffle()
	return textures

func setup_cards():
	var symbols = build_deck()
	var card_scene = preload("res://scenes/minigames/card_matcher/card.tscn")
	for i in range(symbols.size()):
		var card = card_scene.instantiate()
		card.front_texture = symbols[i]
		card.back_texture = preload("res://assets/card_matcher/card_back.png")
		card.connect("card_clicked", Callable(self, "_card_clicked"))
		grid.add_child(card)

func _card_clicked(card):
	if first_card == null:
		first_card = card
	elif second_card == null and card != first_card and card.revealed == false:
		second_card = card
		await get_tree().create_timer(0.5).timeout
		check_match()
	
func check_match():
		if first_card.front_texture == second_card.front_texture:
			matched += 1
			first_card = null
			second_card = null
		else:
			first_card.hide_card()
			second_card.hide_card()
			first_card = null
			second_card = null
			
func _process(delta: float) -> void:
	if matched == pairs:
		emit_signal("complete", self)
