extends CharacterBody2D


const SPEED = 800.0
var bullet_direction = Vector2()


func _physics_process(delta):
	velocity = bullet_direction * SPEED 
	move_and_slide()
