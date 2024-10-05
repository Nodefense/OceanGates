"""
Copyright (C) 2024 Gabriel Dill

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
"""

extends Area2D


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var ship_interior: AnimatedSprite2D = $"../ShipInterior"


func _on_floor_body_entered(body: Node2D) -> void:
	if body.has_method("reemerge") and body.collision_mask == 2 and body.submergeable:
		body.reemerge()
		animation.play("inside")
		ship_interior.play("inside")
		body.submergeable = false
		
func _on_floor_body_exited(body: Node2D) -> void:
	if body.has_method("reemerge") and body.collision_mask == 2 and not body.submergeable:
		body.reemerge()
		animation.play("outside")
		ship_interior.play("outside")
		body.submergeable = true
