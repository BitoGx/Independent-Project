class_name Item
extends Area2D

export var speed: float

onready var pick_up_sfx := $PickUpSFX
onready var sprite := $Sprite
onready var collider := $CollisionShape2D

func _physics_process(delta: float) -> void:
	position += Vector2.DOWN * speed * delta


func _on_Item_body_entered(body):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
