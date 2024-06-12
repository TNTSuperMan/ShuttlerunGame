extends Node

func _on_gym_in_body_entered(body):
	$gymdlg.popup_centered()
	$player.is_can_move = false


func _on_gymdlg_canceled():
	$player.is_can_move = true

func _on_gymdlg_confirmed():
	get_tree().change_scene_to_file("res://scene/shuttlerun/Shuttlerun.tscn")
