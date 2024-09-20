extends CharacterBody2D

@onready var animacao = $AnimatedSprite2D

var fechada = false
var velocidade = 70
var rotacao_velocidade = 2.25
var direcao = Vector2.ZERO
var pe = false  
var pegável = false

func _process(delta):  
	agua()
	movimento(delta)  
	velocity = direcao * velocidade
	move_and_slide()

func movimento(delta):
	direcao = Vector2.ZERO
	if Input.is_action_pressed("Agarrar"):
		fechada = true
	if Input.is_action_just_released("Agarrar"):
			fechada = false
	if Input.is_action_pressed("Esquerda"):
		rotation -= rotacao_velocidade * delta 
	elif Input.is_action_pressed("Direita"):
		rotation += rotacao_velocidade * delta 
	if Input.is_action_pressed("Frente"):
		direcao = Vector2.RIGHT.rotated(rotation)  
	elif Input.is_action_pressed("Atras"):
		direcao = Vector2.LEFT.rotated(rotation)
	if Input.is_action_pressed("Frente") or Input.is_action_pressed("Atras"):
		velocidade = 70
	else:
		direcao = Vector2.ZERO
		if pe:
			animacao.play("PéParado")
		else:
			animacao.play("MeioParado")

func sobe():
	if pe:
		pe = false
	else:
		pe = true

func agua():
	if not pe:
		velocidade = 70
		animacao.play("Meio")
	else:
		velocidade = 90
		animacao.play("Pé")

func _on_alcança_area_entered(area):
	if area.has_method("brilhar"):
		pegável = true
		area.brilhar()

func _on_alcança_area_exited(area):
	if area.has_method("nbrilhar"):
		pegável = false
		area.nbrilhar()
