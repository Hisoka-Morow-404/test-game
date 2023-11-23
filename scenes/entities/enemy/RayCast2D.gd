extends RayCast2D

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.one_shot=true
	timer.wait_time=1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider is CharacterBody2D and "Player" in collider.get_groups():
			if(timer.is_stopped()):
				timer.start()
				collider.hp-=0.1
