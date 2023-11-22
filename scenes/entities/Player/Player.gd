extends CharacterBody2D


const SPEED = 300.0
var timer = Timer.new()


func _ready():
	var weapon = preload("res://scenes/entities/Weapon/Weapon.tscn").instantiate()
	get_node("WeaponPosition/Marker2D").add_child(weapon);
	timer.one_shot = true
	timer.wait_time = 1
	add_child(timer)


func _physics_process(delta):

	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	


	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
	if(Input.is_mouse_button_pressed(1) && timer.is_stopped()):
		timer.start()
		print(timer.is_stopped())
		generate_bullet()
	
func generate_bullet():
	var marker:Node2D = get_node("WeaponPosition/Marker2D")
	var bullet_standard = load("res://scenes/entities/bullet/StandardBullet/StandardBullet.tscn").instantiate()
	bullet_standard.bullet_direction = (get_global_mouse_position() - marker.global_position).normalized()
	bullet_standard.position = marker.global_position
	get_parent().add_child(bullet_standard)
