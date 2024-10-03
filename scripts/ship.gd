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
