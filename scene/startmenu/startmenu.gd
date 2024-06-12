extends Node


func _ready():
	if(!FileAccess.file_exists("user://save.bin")):
		$continue.visible = false

func _on_start_pressed():
	$savedestdlg.popup_centered()
	
func _on_savedestdlg_confirmed():
	get_tree().change_scene_to_file("res://scene/village/village.tscn")

func _on_continue_pressed():
	'''
	var f = FileAccess.open("user://save.bin",FileAccess.WRITE)
	f.store_var({
		"hp" : 100,
		"spk": 8
	})
	'''
	get_tree().change_scene_to_file("res://scene/village/village.tscn")


func _on_credit_pressed():
	get_tree().change_scene_to_file("res://scene/credit/credit.tscn")
