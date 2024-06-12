extends Node3D
var isToZP = false
var isGiveup = false

func _ready():
	$GiveUpDialog.dialog_text = "あなたは限界を超え、倒れました。"
	isGiveup = false
	get_node("player").set_process(true)
	
	for i in range(5):
		get_node("BGM/1").stop()
		if(i == 4):
			get_node("BGM/8").play()
		else:
			get_node("BGM/1").play()
		await get_tree().create_timer(0.8).timeout
		get_node("BGM/1").stop()
		await get_tree().create_timer(0.2).timeout
	
	get_node("BGM/8").stop()
	var level = 1
	var runcount = 0
	$Level.text = "レベル: 1"
	while(!isGiveup):
		for i in range(9):
			if(i == 0):
				get_node("BGM/n").play()
				get_node("BGM/1").play()
				if(runcount + 1 == nextcount(level)):
					get_node("BGM/x").play()
			else:
				get_node("BGM/1").stop()
				get_node("BGM/n").stop()
				get_node("BGM/x").stop()
				if(isToZP):
					if(i >= 2):
						get_node("BGM/" + str(10 - i)).stop()
					get_node("BGM/" + str(9 - i)).play()
				else:
					if(i >= 2):
						get_node("BGM/" + str(i - 1)).stop()
					get_node("BGM/" + str(i)).play()
				
			await get_tree().create_timer(aruntime(level) / 9.0).timeout
		if(isGiveup):
			return
		runcount += 1
		var z = $player.position.z
		if !(z > 10 && isToZP || z < -10 && !isToZP):
			isGiveup = true
			get_node("player").set_process(false)
			$DeathRed.color = Color(1,0,0,0.8)
			$GiveUpDialog.dialog_text = "あなたはシャトルランの線を超えられず、ゲームオーバーしました。"
			$GiveUpDialog.popup_centered()
			return
		isToZP = !isToZP
		if(runcount == nextcount(level)):
			runcount = 0
			level += 1
			$Level.text = "レベル: " + str(level)
			continue

func _on_player_stamina_changed(stamina):
	if(isGiveup):
		return
	var chg = stamina / 100.0 * 1152.0
	$Stamina.set_size(Vector2(chg, 40))
	$DeathRed.color = Color(1,0,0, 
		((1.0 - (stamina / 100.0)) ** 3) / 8.0 * 8.0 - 0.2
	)

func _on_player_give_up():
	isGiveup = true
	get_node("player").set_process(false)
	$GiveUpDialog.popup_centered()

func giveup():
	get_tree().change_scene_to_file("res://scene/village/village.tscn")

func _on_give_up_dialog_confirmed():
	giveup()
func _on_give_up_dialog_canceled():
	giveup()

func _on_player_chech_pos(z):
	if(isGiveup):
		return
	if(z > 10 && isToZP || z < -10 && !isToZP):
		$isComplete.color = Color(0,1,0)
	else:
		$isComplete.color = Color(1,0,0)


func spd(lvl):
	var kms = 0.0
	if(lvl == 1):
		kms = 8.0
	else:
		kms = 8.0 + lvl * 0.5
	return kms * 5.0 / 18.0
func aruntime(lvl):
	return 20.0 / spd(lvl)
func nextcount(lvl):
	var aminrun = spd(lvl) * 3.0 # spd(lvl) * 60.0 / 20.0
	if(round(aminrun) == floor(aminrun)):
		aminrun += 1
	return round(aminrun)
