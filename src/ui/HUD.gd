extends CanvasLayer

onready var score_value := $MarginContainer/ScoreLifeContainer/ScoreContainer/ScoreValue
onready var life_container := $MarginContainer/ScoreLifeContainer/LifeContainer
onready var game_over_container := $MarginContainer/GameOverContainer
onready var pause_container := $MarginContainer/PauseContainer


var life_scene := preload("res://src/ui/Life.tscn")

func _ready() -> void:
  GameData.connect("score_updated", self, "set_score_value")
  GameData.connect("player_life_updated", self, "set_lives")
  GameData.connect("game_over", self, "show_game_over_screen")
  
  set_lives(GameData.player_lives)
func set_score_value(value: int) -> void:
  score_value.text = "%06d" % value
  score_value.show()

func set_lives(value: int) -> void:
  for child in life_container.get_children():
    child.queue_free()
  
  for i in value:
    var life := life_scene.instance()
    life_container.add_child(life)

func show_game_over_screen() -> void:
  game_over_container.show()


func _on_RetryButton_pressed() -> void:
  get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
  if event.is_action_pressed("pause"):
    get_tree().paused = !get_tree().paused
    pause_container.visible = !pause_container.visible
