extends Control

onready var start_menu_container = $StartMenuContainer
onready var option = $Option
onready var video = $Video
onready var audio = $Audio
onready var keybind = $Keybind



func toggle_escape():
  visible = !visible
  get_tree().paused = visible

func show_and_hide(first,second):
  first.show()
  second.hide()

func _process(_delta):
  if Input.is_action_just_pressed("ui_cancel"):
    toggle_escape()
  pass

func _on_StartButton_pressed():
  toggle_escape()
  if get_tree().change_scene("res://src/levels/Level1.tscn") != OK:
    print ("An unexpected error occured when trying to switch to the Readme scene")
  pass

func _on_OptionButton_pressed():
  show_and_hide(option, start_menu_container)

func _on_QuitButton_pressed():
  get_tree().quit()

func _on_AudioButton_pressed():
  show_and_hide(audio, option)

func _on_VideoButton_pressed():
  show_and_hide(video, option)
  
func _on_KeybindButton_pressed():
  
  show_and_hide(keybind, option)

func _on_BackFromOptionButton_pressed():
  show_and_hide(start_menu_container, option)

func _on_FullscreenCheckBox_toggled(button_pressed):
  OS.window_fullscreen = button_pressed

func _on_BorderlessCheckBox_toggled(button_pressed):
  OS.window_borderless = button_pressed

func _on_BackFromVideoButton_pressed():
  show_and_hide(option, video)

func _on_BackFromAudioButton_pressed():
  show_and_hide(option, audio)

func _on_BackFromKeybindButton_pressed():
  show_and_hide(option, keybind)

func _on_UpBindButton_pressed():
  var new_input = InputEventKey.new()
  new_input.set_scancode(KEY_W)
  InputMap.add_action("move_up")
  InputMap.action_add_event("move_up",new_input)
