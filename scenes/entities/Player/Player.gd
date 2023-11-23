extends CharacterBody2D


const SPEED = 250.0
var timer = Timer.new()


func _ready():
	var weapon = preload("res://scenes/entities/Weapon/Weapon.tscn").instantiate()
	get_node("WeaponPosition/Marker2D").add_child(weapon);
	timer.one_shot = true
	timer.wait_time = 0.1
	add_child(timer)


func _physics_process(delta):	
	moveAndAnimate(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	handleActions()
	
func generate_bullet():
	var marker:Node2D = get_node("WeaponPosition/Marker2D")
	var bullet_standard = load("res://scenes/entities/bullet/StandardBullet/StandardBullet.tscn").instantiate()
	bullet_standard.bullet_direction = (get_global_mouse_position() - marker.global_position).normalized()
	#Il problema dovrebe essere che istanziando il marker da codice prende la posizione della sua scena,
	# l'add_child dovremme di default mettere la posizione adattata al padre
	#bullet_standard.global_position = marker.global_position
	#bullet_standard.position = $WeaponPosition/Marker2D.global_position
	print("bullet direction: ", bullet_standard.bullet_direction)
	print("posizione bullet: ", bullet_standard.global_position)
	print("posizione marker: ", marker.global_position)
	print("Posizione player: ", self.global_position)
	self.add_child(bullet_standard)

func moveAndAnimate(x,y):
	move(x,y)
	animate(x,y)
	
func move(x,y):
	
	var movement = Vector2(x,y)
	movement.normalized() 
	velocity = movement * SPEED
#	if x:
#		velocity.x = x * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#	if y:
#
#		velocity.y = y * SPEED
#	else:
#		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	
func animate(x,y):
	if x:
		if !y:
			$Bug/Animation.play("RunSide")
			$Bug.flip_h = x < 0
		if y<0 : #leftdiag
			$Bug/Animation.play("left_up_diag")
			$Bug.flip_h = x > 0
		elif y>0:
			$Bug/Animation.play("left_down_diag")
			$Bug.flip_h = x > 0
	elif y:
		if y<0 :$Bug/Animation.play("runUp")
		elif y>0: $Bug/Animation.play("runDown")
	else:	
		$Bug/Animation.play("Idle")

func handleActions():
	if(Input.is_mouse_button_pressed(1) && timer.is_stopped()):
		timer.start()
		generate_bullet()
