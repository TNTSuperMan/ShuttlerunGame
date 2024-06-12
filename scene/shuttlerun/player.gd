extends CharacterBody3D
signal stamina_changed(stamina)
signal give_up
signal chech_pos(z)

var stamina = 0.0
var cps = 0
var isStop = true

func _ready():
	stamina = 100
	cps = 0.1 # 読込プログラム書け
	await get_tree().create_timer(5).timeout
	isStop = false

func _process(delta):
	if(isStop):
		return
	var move = 0
	if(Input.is_action_just_pressed("up")):
		move -= 0.03
	if(Input.is_action_just_pressed("down")):
		move += 0.03
	if(move != 0):
		velocity += Vector3(sin(rotation.y),0,cos(rotation.y)) * move
		stamina -= cps
		stamina_changed.emit(stamina)
	else:
		velocity *= 0.98
	if(Input.is_action_just_pressed("turn")):
		rotate_y(PI)
	move_and_collide(velocity)
	chech_pos.emit(position.z)
	
	if(stamina <= 0):
		give_up.emit()
