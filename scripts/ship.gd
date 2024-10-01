extends Area2D
@onready var animacao = $AnimatedSprite2D
@onready var ship_interior = $"../ShipInterior"

func _on_chão_body_entered(body):
	if body.has_method("sobe") and body.collision_mask == 2:
		body.sobe()
		animacao.play("Dentro")
		ship_interior.play("dentro")

func _on_chão_body_exited(body):
	if body.has_method("sobe"):
		body.sobe()
		animacao.play("Fora")
		ship_interior.play("fora")
