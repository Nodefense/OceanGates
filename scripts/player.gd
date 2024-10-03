'''
Copyright (C) 2024 Leonardo Bandeira, Gabriel Dill

This file is part of OceanGates.

OceanGates is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

OceanGates is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with OceanGates.
If not, see <https://www.gnu.org/licenses/>. 
'''

extends CharacterBody2D

@onready var animacao = $AnimatedSprite2D

var fechada = false
var velocidade = 70
var rotacao_velocidade = 2.25
var direcao = Vector2.ZERO
var pe = false  
var pegável = false
@onready var water = $"../Water"
@onready var surface = $"../Surface"


func _process(delta):  
	agua()
	movimento(delta)  
	velocity = direcao * velocidade
	move_and_slide()

func movimento(delta):
	direcao = Vector2.ZERO
	if Input.is_action_pressed("Agarrar"):
		fechada = true
		
	if Input.is_action_just_pressed("Afundar"):
		if surface.enabled:
			surface.enabled = false
		elif not surface.enabled:
			surface.enabled = true
		if collision_mask == 2:
			collision_mask = 1
		elif collision_mask == 1:
			collision_mask = 2
		if z_index == 1:
			z_index = -1; print(z_index)
		elif z_index == -1:
			z_index = 1; print(z_index)
		
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
