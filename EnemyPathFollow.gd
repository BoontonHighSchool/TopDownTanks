extends KinematicBody2D

var speed = 50
var enemy_types = ["blue", "green", "red", "sand"]
var HitCount = 3
var BigExplosionOBJ = preload("res://BigExplosion.tscn")

onready var parent = get_parent()

func _ready():
	set_process(true)
	randomize()
	$AnimatedSprite.animation = enemy_types[randi() % enemy_types.size()]


func _process(delta):
	get_parent().set_offset(get_parent().get_offset() + ((speed * Global.Difficulty) * delta))

	if HitCount == 0:
		var explosion = BigExplosionOBJ.instance()
		explosion.position = self.get_position()
		get_parent().add_child(explosion)
		Global.score += 1
		Global.EnemyCount -= 1
		queue_free()

func kill():
	HitCount = HitCount - 1