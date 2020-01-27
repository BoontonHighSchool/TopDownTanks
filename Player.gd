extends KinematicBody2D
# Uncomment the below line(s) for Space Shooter / Asteroids Style Screenwrap	
#onready var screen_size = get_viewport_rect().size

var speed = 200
var rotation_speed = 3
var score = 0

var velocity = Vector2()
var rotation_dir = 0

var MissleOBJ = preload("res://MissleRoot.tscn")

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		velocity -= transform.x * speed
	if Input.is_action_pressed('ui_up'):
		velocity += transform.x * speed
	if Input.is_action_pressed("ui_accept"):
		if($CoolDown.time_left == 0):
			var missle = MissleOBJ.instance()
			missle.position = $Muzzle.global_position
			missle.rotation = self.global_rotation
			get_parent().add_child(missle) # don't want bullet to move with me, so add it as child of parent
			$CoolDown.start()

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	if Global.EnemyCount == 0:
		get_tree().change_scene("res://WinScreen.tscn")


# Uncomment the below line(s) for Space Shooter / Asteroids Style Screenwrap	
#	position.x = wrapf(position.x, 0, screen_size.x)
#	position.y = wrapf(position.y, 0, screen_size.y)

	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
		if collision.collider.name == "Enemy-PathFollow":
			self.kill()

func kill():
	get_tree().change_scene("res://LoseScreen.tscn")
	


