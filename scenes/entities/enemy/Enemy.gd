extends CharacterBody2D



var SPEED = 100
var value = randf_range(-1, 1)
var direction = Vector2(value,value).normalized()
var timer = Timer.new()
var hp = 100
var target

func _ready():
	timer.wait_time = 3
	timer.one_shot = true
	add_child(timer)

func _physics_process(delta):
	if target:
		direction = (target.get_global_position() - self.get_global_position()).normalized()
	else:
		if timer.is_stopped():
			timer.start()
			changeDirection(-1000, 1000)
	
	velocity = direction * SPEED
	move_and_slide()
	
	isAlive()

func changeDirection(a:int, b:int):
	value = randf_range(a, b)
	var value2 = randf_range(a, b)
	direction = Vector2(value,value2).normalized()


func _on_fov_body_entered(body):
	if "Player" in body.get_groups():
		SPEED = 150
		target = body


func _on_fov_body_exited(body):
	if "Player" in body.get_groups():
		SPEED = 50
		target = null

func isAlive():
	if hp <= 0 :
		queue_free()
