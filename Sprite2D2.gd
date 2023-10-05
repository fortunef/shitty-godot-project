extends Sprite2D

var canFire = true
var bullet = preload("res://bullet.tscn")


func _physics_process(delta):
	var mousePos = get_global_mouse_position()
	look_at(mousePos)

	if Input.is_action_pressed("Fire") and canFire == true:
		var bulletInstance = bullet.instantiate()
		bulletInstance.rotation = rotation
		bulletInstance.global_position = $Marker2D.global_position
		get_parent().add_child(bulletInstance)
		canFire = false
		await get_tree().create_timer(0.2).timeout
		canFire = true
	
