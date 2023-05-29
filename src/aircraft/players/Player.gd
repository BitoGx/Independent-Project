class_name Player
extends Aircraft

const MINIMUM_SCREEN_LIMIT := Vector2(10, 8)
const MAXIMUM_SCREEN_LIMIT := Vector2(278,503)

onready var invinvibility_timer := $InvincibilityTimer
onready var shooting_sfx := $ShootingSFX

func control(delta: float) -> void:
  direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  velocity = direction.normalized() * speed
  
  velocity = move_and_slide(velocity)
  
  position.x = clamp(position.x, MINIMUM_SCREEN_LIMIT.x,MAXIMUM_SCREEN_LIMIT.x)
  position.y = clamp(position.y, MINIMUM_SCREEN_LIMIT.y,MAXIMUM_SCREEN_LIMIT.y)
  
  if Input.is_action_pressed("action_shoot") and can_shoot:
    shoot()

func shoot() -> void:
  shooting_sfx.play()
  can_shoot = false
  gun_timer.start()
  var dir := Vector2.UP
  emit_signal("shot", bullet_scene, muzzle, dir)
  
func hit(damage: float) -> void:
  if invinvibility_timer.is_stopped():
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
  
  explosion_sfx.play()
  
  animation_player.play("explosion")
  yield(animation_player,"animation_finished")
  
  GameData.player_lives -= 1
  
  if(GameData.player_lives > 0):
    is_alive = true
    bullet_scene = preload("res://src/projectiles/PlayerBulletA.tscn")
    invinvibility_timer.start()
    animation_player.play("respawn")
  else:
    GameData.emit_signal("game_over")

func power_up():
  bullet_scene = preload("res://src/projectiles/PlayerBulletB.tscn")


func _on_InvincibilityTimer_timeout():
  animation_player.stop()
  sprite.show()
  collider.set_deferred("disabled", false)
  hit_collider.set_deferred("disabled", false)
