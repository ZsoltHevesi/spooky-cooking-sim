extends Interactible


func _on_interacted(body: Variant) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_node("../player").hud.get_node("reticle").visible = false
	get_node("../player").hud.get_node("reticle_text").visible = false
	get_node("../player").hud.get_node("dialog_margin").visible = true
	get_node("../player").hud.get_node("dialog_margin/dialog_box/speaker_name").text = "John NPC"
	get_node("../player").hud.get_node("dialog_margin/dialog_box/speaker_text").text = "Hello everybody, my name is Markiplier and welcome to Five Nights at Freddy's, an indie horror game that you guys suggested, en masse, and I saw that Yamimash played it and he said it was really really good... So I'm very eager to see what is up. And that is a terrifying animatronic bear! 'Family pizzeria looking for security guard to work the nightshift.' Oh... 12 a.m. The first night. If I didn't wanna stay the first night, why would I stay any more than... five... Why I stay any more than two- hello? Okay..."
	get_node("../player").set_physics_process(false)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("LMB"):
		get_node("../player").set_physics_process(true)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_node("../player").hud.get_node("reticle").visible = true
		get_node("../player").hud.get_node("reticle_text").visible = true
		get_node("../player").hud.get_node("dialog_margin").visible = false
