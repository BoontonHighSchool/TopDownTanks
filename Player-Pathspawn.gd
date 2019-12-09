extends Area2D

export var rot_speed = 2.6
export var thrust = 250
export var max_vel = 300
export var friction = 0.8

var velocity = Vector2()
var acceleration = Vector2()
var MissleOBJ = preload("res://MissleRoot.tscn")

func _ready():

	set_process(true)
	
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation += rot_speed * delta	
	if Input.is_action_pressed("ui_right"):
		rotation -= rot_speed * delta
	if Input.is_action_pressed("ui_up"):
		acceleration = Vector2(thrust, 0).rotated(rotation)
	else:
		acceleration = Vector2(0, 0)
	if Input.is_action_pressed("ui_accept"):
		if($CoolDown.time_left == 0):
			var missle = MissleOBJ.instance()
			missle.position = $Muzzle.global_position
			missle.rotation = self.global_rotation
			get_parent().add_child(missle) # don't want bullet to move with me, so add it as child of parent
			$CoolDown.start()
	
	acceleration += velocity * friction
	velocity += acceleration * delta
	velocity = velocity.clamped(max_vel)
	position += velocity * delta


func kill():
	get_tree().reload_current_scene()

#
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#extends RigidBody2D
## Uncomment the below line(s) for Space Shooter / Asteroids Style Screenwrap
##onready var screen_size = get_viewport_rect().size
#
#var speed = 200
#var rotation_speed = 3
#
#var velocity = Vector2()
#var rotation_dir = 0
#
#var MissleOBJ = preload("res://MissleRoot.tscn")
#
#func get_input():
#	rotation_dir = 0
#	velocity = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		rotation_dir += 1
#	if Input.is_action_pressed('ui_left'):
#		rotation_dir -= 1
#	if Input.is_action_pressed('ui_down'):
#		velocity -= transform.x * speed
#	if Input.is_action_pressed('ui_up'):
#		velocity += transform.x * speed
#	if Input.is_action_pressed("ui_accept"):
#		if($CoolDown.time_left == 0):
#			var missle = MissleOBJ.instance()
#			missle.position = $Muzzle.global_position
#			missle.rotation = self.global_rotation
#			get_parent().add_child(missle) # don't want bullet to move with me, so add it as child of parent
#			$CoolDown.start()
#
#func _physics_process(delta):
#	get_input()
#	rotation += rotation_dir * rotation_speed * delta
#	velocity = move_and_slide(velocity)
#
#	if $R_Down.is_colliding():
#		if $R_Down.get_collider().is_in_group("Enemy"):
#			self.kill()
#	if $R_Up.is_colliding():
#		if $R_Up.get_collider().is_in_group("Enemy"):
#			self.kill()
#	if $R_Back.is_colliding():
#		if $R_Back.get_collider().is_in_group("Enemy"):
#			self.kill()
#	if $R_Front.is_colliding():
#		if $R_Front.get_collider().is_in_group("Enemy"):
#			self.kill()
#
#func kill():
#	get_tree().reload_current_scene()
#
## Uncomment the below line(s) for Space Shooter / Asteroids Style Screenwrap
##	position.x = wrapf(position.x, 0, screen_size.x)
##	position.y = wrapf(position.y, 0, screen_size.y)
#
