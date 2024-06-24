extends Node3D
#This node acts as a "pivot" for the purposes of rotating the camera around our little diorama
#Length of time (in seconds) the camera will take to complete it's rotation
@export var rotation_speed := 1.0
@onready var sfx_rotate = $SFXRotate
@onready var camera_3d = $Camera3D

var tween: Tween = null

#These are used to determine what direction to pan the camera
var right_vector
var forward_vector
var pan_speed := 0.1
var dragging := false

var screen_ratio

func _ready():
	pass
	
func _process(delta):
	rotate_camera()
	pass

func tween_finished():
	tween = null;
	
func get_move_vectors():
	var offset = camera_3d.global_position - global_position
	right_vector = camera_3d.transform.basis.x
	forward_vector = Vector3(offset.x, 0, offset.z).normalized()

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_RIGHT:
			#dragging = true
		#else:
			#dragging = false
	#elif event is InputEventMouseMotion:
		#var new_position = (right_vector * event.relative.x * pan_speed) + (forward_vector * event.relative.y * pan_speed)
		##global_position += Vector3((right_vector * event.relative.x * pan_speed), (forward_vector * event.relative.y * pan_speed), 0 )
	#
func rotate_camera():
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


func pan_camera(delta):
	var pan_movement = Vector3.ZERO
	if Input.is_action_pressed("pan_left"):
		print("left")
		pan_movement.x -= 1
	if Input.is_action_pressed("pan_right"):
		print("right")
		pan_movement.x += 1
	if Input.is_action_pressed("pan_up"):
		print("up")
		pan_movement.y += 1
	if Input.is_action_pressed("pan_down"):
		print("down")
		pan_movement.y -= 1
	pan_movement = pan_movement.normalized()
	position += pan_movement * delta
