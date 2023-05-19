extends Node

signal score_updated
signal player_life_updated
signal game_over

var score := 0 setget set_score
var player_lives := 3 setget set_player_lives

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated", score)

func set_player_lives(value: int) -> void:
	player_lives = value
	emit_signal("player_life_updated", player_lives)
