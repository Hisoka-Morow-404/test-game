extends CharacterBody2D



const SPEED = 300.0
var value = randf_range(-1, 1)
var direction = Vector2(value,value).normalized()

func _physics_process(delta):
	position += direction * SPEED * delta

