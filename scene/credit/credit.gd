extends Node
var y = 700
# Called when the node enters the scene tree for the first time.
func _ready():
	$BGM.play(2)

func _process(delta):
	if(y < -2246):
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://scene/startmenu/startmenu.tscn")
	y -= delta * 60
	if(Input.is_action_pressed("up")):
		y += delta * 60
	elif(Input.is_action_pressed("down")):
		y -= delta * 120
	$text.set_position(Vector2(0,y))
