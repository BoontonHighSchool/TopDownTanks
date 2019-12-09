extends KinematicBody2D

var speed = 50
var enemy_types = ["blue", "green", "red", "sand"]

onready var parent = get_parent()

func _ready():
	set_process(true)
	randomize()
	$AnimatedSprite.animation = enemy_types[randi() % enemy_types.size()]


func _process(delta):
	get_parent().set_offset(get_parent().get_offset() + (speed * delta))


func kill():
	queue_free()