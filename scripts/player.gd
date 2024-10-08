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


extends CharacterBody2D


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var water: TileMapLayer = $"../Water"
@onready var surface: TileMapLayer = $"../Surface"


var closed: bool = false
var speed: int = 70
var rotation_speed: float = 2.25
var direction: Vector2 = Vector2.ZERO
var water_reach: bool = false  
var grabbable: bool = false
var submergeable: bool = true


func _process(delta: float) -> void:  
	water_function()
	movement(delta)  
	velocity = direction * speed
	move_and_slide()

# Player movement
func movement(delta: float) -> void:
	direction = Vector2.ZERO
	if Input.is_action_pressed("grab"):
		closed = true
		
	if Input.is_action_just_pressed("submerge") and submergeable:
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
		
	if Input.is_action_just_released("grab"):
		closed = false
			
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
		
	elif Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
		
	if Input.is_action_pressed("front"):
		direction = Vector2.RIGHT.rotated(rotation)
		 
	elif Input.is_action_pressed("back"):
		direction = Vector2.LEFT.rotated(rotation)
		
	if Input.is_action_pressed("front") or Input.is_action_pressed("back"):
		speed = 70
	else:
		direction = Vector2.ZERO
		if water_reach:
			animation.play("surface_idle")
		else:
			animation.play("water_idle")

# Invert the value of water_reach
func reemerge() -> void:
	if water_reach:
		water_reach = false
	else:
		water_reach = true

# Plays water_moving animation if the player is in water
func water_function() -> void:
	if not water_reach:
		speed = 70
		animation.play("water_moving")
	else:
		speed = 90
		animation.play("surface_moving")

# For objects on the floor next to the player
func _on_range_area_entered(area: Area2D) -> void:
	if area.has_method("glow"):
		grabbable = true
		area.glow()

# For objects on the floor next to the player
func _on_range_area_exited(area: Area2D) -> void:
	if area.has_method("gloom"):
		grabbable = false
		area.gloom()
