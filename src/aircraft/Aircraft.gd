class_name Aircraft
extends KinematicBody2D

signal shot

export var health: float
export var speed: float
export var hit_damage: float
export var bullet_scene: PackedScene

onready var gun_timer := $GunTimer
onready var muzzle := $Muzzle
onready var sprite := $Sprite
onready var collider := $CollisionShape2D
onready var hit_collider := $HitArea/CollisionShape2D
onready var animation_player := $AnimationPlayer
onready var explosion_sfx := $ExplosionSFX

var direction: Vector2
var velocity: Vector2
var is_alive:= true
var can_shoot := true

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	control(delta)

func control(delta: float) -> void:
	pass

func shoot() -> void:
	pass

func hit(damage: float) -> void:
	health -= damage
	if health <= 0:
		die()
	else:
		animation_player.play("damaged")

func die() -> void:
	is_alive = false
	sprite.hide()
	collider.set_deferred("disabled", true)
	hit_collider.set_deferred("disabled", true)
	
	animation_player.play("explosion")
	yield(animation_player,"animation_finished")
	
	queue_free()

func _on_HitArea_body_entered(body):
	if body.has_method("hit"):
		body.hit(hit_damage)

func _on_GunTimer_timeout():
	can_shoot = true
