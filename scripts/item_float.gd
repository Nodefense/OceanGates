extends Area2D

@onready var player = get_node("res://Cenas/player.tscn")
@onready var anima = $AnimatedSprite2D

func brilhar():
	anima.play("Brilha")

func nbrilhar():
	anima.play("Boia")
