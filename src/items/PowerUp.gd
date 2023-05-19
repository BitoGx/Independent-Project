extends Item

func _on_Item_body_entered(body):
	if body.has_method("power_up"):
		body.power_up()
		
		sprite.hide()
		collider.set_deferred("disbaled", true)
		
		pick_up_sfx.play()
		yield(pick_up_sfx, "finished")
	queue_free()
