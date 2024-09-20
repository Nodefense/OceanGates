extends Area2D
@onready var animacao = $AnimatedSprite2D
@onready var etc = $"../Etc"

func _on_chão_body_entered(body):
	if body.has_method("sobe"):
		body.sobe()
		animacao.play("Dentro")
		etc.play("dentro")

func _on_chão_body_exited(body):
	if body.has_method("sobe"):
		body.sobe()
		animacao.play("Fora")
		etc.play("fora")
