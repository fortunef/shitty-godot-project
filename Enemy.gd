extends CharacterBody2D

@export var speed = 300
@export var jump = -500
@export var gravity = 9.5
@export var UP = Vector2(0, - 1)

var motion = Vector2()

var move = true
var direction = 1
var alive = true
var health = 10
var canTakeDamage = true
var weaponName = ""
var weaponDamage = 0

func _physics_process(delta):
	motion.y += gravity
	
	if move == true:
		erection()
		motion.x += direction
		
	move_and_slide()
		
func erection():
	if motion.x == 100:
		direction = -1
	elif motion.x == -100:
		direction = 1
		
func damage():
	if canTakeDamage == true:
		if health > 0:
			health - health - weaponDamage
			if health <= 0:
				alive = false
				if alive == false:
					queue_free()
					print("Enemy Has DIed")
			elif health > 0:
				print(health)

func _on_area_2d_area_entered(area):
	weaponName = "AR"
	print(weaponName, "bullet has hit enemy!")
	weaponDamage = 2
	damage()
	
	
