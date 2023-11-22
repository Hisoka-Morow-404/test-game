extends CharacterBody2D


const SPEED = 450.0
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
		$Bug/Animation.play("RunSide")
		if directionX < 0 : $Bug.flip_h = true 
		else : $Bug.flip_h = false
		velocity.x = directionX * SPEED
	else:
		#$Bug/Animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		if directionY<0 :$Bug/Animation.play("runUp")
		elif directionY>0: $Bug/Animation.play("runDown")
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
		
	if not directionX and not directionY: $Bug/Animation.play("Idle")	
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
