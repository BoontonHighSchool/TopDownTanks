extends Node2D

var ExplosionOBJ = preload("res://Explosion.tscn")
var EnemyExplosionOBJ = preload("res://EnemyExplosion.tscn")

func _ready():
	pass

func _process(delta):
	move_local_x(delta * 400)


func _on_Area2D_area_entered(area):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

 
func _on_Area2D_body_entered(body):
	if body.is_in_group("Obstacle"):
		var explosion = ExplosionOBJ.instance()
		explosion.position = self.global_position
		explosion.rotation = self.global_rotation
		get_parent().add_child(explosion)
		if body.has_method("kill"):
			body.kill()
		queue_free()

	if body.is_in_group("Enemy"):
		var enemyex = EnemyExplosionOBJ.instance()
		enemyex.position = self.global_position
		enemyex.rotation = self.global_rotation
		get_parent().add_child(enemyex)
		if body.has_method("kill"):
			body.kill()
		queue_free()