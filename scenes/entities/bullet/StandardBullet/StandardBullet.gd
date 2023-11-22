extends CharacterBody2D


const SPEED = 800.0
var bullet_direction = Vector2()


func _physics_process(delta):
	velocity = bullet_direction * SPEED 
	move_and_slide()
	

func _on_hit_box_body_entered(body):
	if body is StaticBody2D:
		queue_free()
