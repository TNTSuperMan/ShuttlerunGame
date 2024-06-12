extends CharacterBody2D
var is_can_move = true

func _ready():
	is_can_move = true

func _process(_delta):
	if(!is_can_move):
		return
	if(Input.is_action_pressed("click")):
		#velocity += get_local_mouse_position()
		var pos = get_local_mouse_position()
		pos /= sqrt(pos.x ** 2 + pos.y ** 2) / 250
		velocity = pos
	else:
		velocity = Input.get_vector("left","right","up","down") * 250
	move_and_slide()
