extends Label

func _process(delta):
	pass

func _on_help_body_entered(body):
	visible = true
	get_node("../descback").visible = true

func _on_help_body_exited(body):
	visible = false
	get_node("../descback").visible = false
