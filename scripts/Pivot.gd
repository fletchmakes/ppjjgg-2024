extends Node3D
#This node acts as a "pivot" for the purposes of rotating the camera around our little diorama
#Length of time (in seconds) the camera will take to complete it's rotation
@export var rotation_speed := 1.0
@onready var sfx_rotate = $SFXRotate

var tween: Tween = null

func _ready():
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("rotate_left") and tween == null:
		#print("rotate left")
		sfx_rotate.play()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($".", "rotation", rotation + Vector3(0, 1.57, 0), rotation_speed)
		tween.tween_callback(tween_finished)
		
	elif Input.is_action_just_pressed("rotate_right") and tween == null:
		#print("rotate right")
		sfx_rotate.play()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($".", "rotation", rotation + Vector3(0, -1.57, 0), rotation_speed)
		tween.tween_callback(tween_finished)		

func tween_finished():
	tween = null;
