class_name Projectile

extends Area2D

export var speed: float
export var damage: float

var direction: Vector2

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	


func _on_Projectile_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


