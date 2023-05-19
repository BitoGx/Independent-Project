class_name Enemy
extends Aircraft

signal item_spawned

export var score: int

onready var hit_sfx := $HitSFX

var target: Player = null
var power_up := preload("res://src/items/PowerUp.tscn")

func _ready() -> void:
	can_shoot = false

func control(delta: float) -> void:
	direction = Vector2.DOWN
	
	velocity = direction * speed
	
	velocity = move_and_slide(velocity)
	
	if target and can_shoot:
		shoot()

func shoot() -> void:
	can_shoot = false
	gun_timer.start()
	
	var target_pos = target.global_position
	var muzzle_pos = muzzle.global_position
	var dir = (target_pos - muzzle_pos).normalized()
	
	emit_signal("shot", bullet_scene, muzzle, dir)
	
func hit(damage: float) -> void:
	health -= damage
	if health <= 0:
		die()
	else:
		animation_player.play("damaged")
		hit_sfx.play()

func die() -> void:
	is_alive = false
	sprite.hide()
	collider.set_deferred("disabled", true)
	hit_collider.set_deferred("disabled", true)
	
	explosion_sfx.play()
	
	if randf() > 0.7:
		emit_signal("item_spawned", power_up, global_position)
	
	GameData.score += score
	
	animation_player.play("explosion")
	yield(animation_player,"animation_finished")
	
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_DetectArea_body_entered(body):
	if body is Player:
		target = body

func _on_DetectArea_body_exited(body):
	if body is Player:
		target = null

func _on_VisibilityNotifier2D_screen_entered():
	gun_timer.start()
