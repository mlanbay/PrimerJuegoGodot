extends CharacterBody2D

var direccion
var moving = false
const GRID_SIZE = 16
@onready var ray: RayCast2D = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D 

func _physics_process(delta: float) -> void:
	direccion=Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direccion= Vector2.RIGHT
		animated_sprite.play("right")
		move()
	elif Input.is_action_pressed("ui_left"):
		direccion= Vector2.LEFT
		animated_sprite.play("left")
		move()
	elif Input.is_action_pressed("ui_up"):
		direccion=Vector2.UP
		animated_sprite.play("up")
		move()
	elif Input.is_action_pressed("ui_down"):
		direccion=Vector2.DOWN
		animated_sprite.play("down")
		move()
	move_and_slide()

func move()-> void:
	if direccion:
		
		var next_tile: Vector2 = direccion * GRID_SIZE 
		ray.target_position =next_tile
		if(!ray.is_colliding()):
			if moving==false:
				
				moving=true
				var tween = create_tween()
				tween.tween_property(self,"position",position+direccion*GRID_SIZE, 0.25)
				tween.tween_callback(moving_false)
		else :
			moving_false()
			
func moving_false()-> void:
	moving=false
	animated_sprite.stop()
