extends Node3D
#This node acts as a "pivot" for the purposes of rotating the camera around our little diorama
#Length of time (in seconds) the camera will take to complete it's rotation
@export var rotation_speed := 1.0
@onready var sfx_rotate = $SFXRotateCamera
@onready var camera_3d = $Camera3D

@onready var home_position = global_position

var tween: Tween = null

#These are used to determine what direction to pan the camera
var right_vector
var forward_vector
# CHANGE THIS IF YOU WANT SOREN
var pan_speed := 0.001
var dragging := false

var screen_ratio

func _ready():
	camera_3d = get_node("Camera3D");
	var screen_size = get_viewport().get_visible_rect().size;
	screen_ratio = screen_size.y / screen_size.x
	get_move_vectors()
	
func _process(delta):
	#rotate_camera()
	pass

func tween_finished():
	tween = null;
	
func get_move_vectors():
	var offset = camera_3d.global_position - global_position
	right_vector = camera_3d.transform.basis.x
	forward_vector = Vector3(offset.x, 0, offset.z).normalized()

func _input(event):
	if (event is InputEventMouseButton):
		if (event.pressed and event.button_index == MOUSE_BUTTON_RIGHT):
			dragging = true;
		else:
			dragging = false;
			
	elif (event is InputEventMouseMotion and dragging):
		# pan camera
		global_position += camera_3d.global_transform.basis.x * -event.relative.x * pan_speed + forward_vector * -event.relative.y * pan_speed / screen_ratio
	
	if (event is InputEventKey and event.is_pressed() and event.is_action("ui_space")):
		# send the camera back to it's original position
		global_position = home_position


func pan_camera(delta):
	var pan_movement = Vector3.ZERO
	if Input.is_action_pressed("pan_left"):
		pan_movement.x -= 1
	if Input.is_action_pressed("pan_right"):
		pan_movement.x += 1
	if Input.is_action_pressed("pan_up"):
		pan_movement.y += 1
	if Input.is_action_pressed("pan_down"):
		pan_movement.y -= 1
	pan_movement = pan_movement.normalized()
	position += pan_movement * delta
