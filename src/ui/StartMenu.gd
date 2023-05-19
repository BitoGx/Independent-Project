extends Control



func _on_StartButton_pressed():
	get_tree().change_scene("res://src/levels/Level1.tscn")


func _on_OptionButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
