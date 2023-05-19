extends Node2D

onready var enemies := $Enemies
onready var projectiles:= $Projectiles
onready var items:= $Items

var enemies_scene := preload("res://src/aircraft/enemies/Enemy.tscn")

func _ready() -> void:
	randomize()
	GameData.score = 0
	GameData.player_lives = 3

func _on_Aircraft_shot(projectile_scene: PackedScene, pos: Node2D, dir: Vector2) -> void:
	var projectile: Area2D = projectile_scene.instance()
	projectiles.add_child(projectile)
	projectile.transform = pos.global_transform
	projectile.direction = dir
	projectile.rotation = dir.angle()

func _on_Enemy_item_spawned(item_scene: PackedScene, pos: Vector2):
	var item: Area2D = item_scene.instance()
	items.call_deferred("add_child", item)
	item.position = pos

func _on_SpawnTimer_timeout():
	var enemy: Enemy = enemies_scene.instance()
	enemies.add_child(enemy)
	
	enemy.global_position.y = -32
	enemy.global_position.x = randi() % 257 + 16
	
	enemy.connect("shot", self, "_on_Aircraft_shot")
	enemy.connect("item_spawned", self,"_on_Enemy_item_spawned")
