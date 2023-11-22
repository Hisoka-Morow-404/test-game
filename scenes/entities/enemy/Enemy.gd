extends CharacterBody2D



const SPEED = 300.0
var value = randf_range(-1, 1)
var direction = Vector2(value,value).normalized()
var timer = Timer.new()

func _ready():
	timer.one_shot = true
	timer.wait_time = 3
	

func _physics_process(delta):
	if(timer.is_stopped()):
		timer.start()
		changeDirection(-10, 10)
		velocity += direction * SPEED * delta
		
		
	move_and_slide()

func changeDirection(a:int, b:int):
	value = randf_range(a, b)
	var direction = Vector2(value,value).normalized()
