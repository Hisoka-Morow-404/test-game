extends Node

func _ready():
	for enemyNum in 10:
		var enemy = preload("res://scenes/entities/enemy/Enemy.tscn").instantiate()
		var mapSize = $Map/TileMap.get_used_rect().size
		var x = randf_range(0,mapSize.x)*16
		var y = randf_range(0,mapSize.y)*16
		enemy.position = Vector2(x,y)
		add_child(enemy)
