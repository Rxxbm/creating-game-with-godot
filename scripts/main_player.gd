extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player_state 

func _physics_process(delta: float):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
	
	velocity = direction * SPEED 
	move_and_slide()
	
	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("up_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("down_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("right_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("left_walk")
		
	
