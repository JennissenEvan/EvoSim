extends Camera2D

var speed = 300
var zoomfactor = 1.0

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta * zoomfactor
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta * zoomfactor
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta * zoomfactor
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta * zoomfactor
	
	zoom = Vector2(zoomfactor, zoomfactor)

func _input(event):
	if event.is_action_pressed("ui_scroll_up"):
		if zoomfactor > 0.2:
			zoomfactor -= 0.1
	if event.is_action_pressed("ui_scroll_down"):
		zoomfactor += 0.1