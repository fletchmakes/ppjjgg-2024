extends Node3D

# track special objects that will change here
@onready var water_bottle_state_1 = $"Environment/Interactables/water bottle plain"
@onready var water_bottle_state_2 = $"Environment/Interactables/water bottle with stickers"
@onready var journal_state_1 = $"Environment/Interactables/journal-closed"
@onready var journal_state_2 = $"Environment/Interactables/journal-open2"
@onready var sticker_sheets = $"Environment/Interactables/sticker sheets"
@onready var plant_state_1 = $"Environment/Interactables/smol plant"
@onready var plant_state_2 = $"Environment/Interactables/big plant"
@onready var sfx_rotate = $SFXRotate
@onready var camera_3d = $Pivot/Camera3D
@onready var room = $Environment
@onready var wall_1_meshes = get_tree().get_nodes_in_group("wall_1")
@onready var wall_2_meshes = get_tree().get_nodes_in_group("wall_2")
@onready var wall_3_meshes = get_tree().get_nodes_in_group("wall_3")
@onready var wall_4_meshes = get_tree().get_nodes_in_group("wall_4")
@onready var sock = $Environment/sock
@onready var book_collision = $Environment/Books

var zoomTarget
var zoomSpeed := 0.1

var right_vector := Vector3.ZERO
var forward_vector := Vector3.ZERO
var rotation_speed := 1.0
var tween : Tween = null
var tween_2 : Tween = null

var wall_fade_speed := 0.5

#This keeps track of how rotated the room is so it knows which walls to show or hide
var rotation_tracker := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	zoomTarget = camera_3d.size
	for mesh in wall_3_meshes:
		mesh.transparency = 1.0
	for mesh in wall_4_meshes:
		mesh.transparency = 1.0
	# let the GameManager have a reference to this so that it can control
	# nodes within this scene
	GameManager.World1RootNode = self;

func _process(delta):
	#zoom_environment(delta)
	rotate_environment()
	pass
	
func rotate_environment():
	if Input.is_action_just_pressed("rotate_left") and tween == null:
		#print("rotate left")
		sfx_rotate.play()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(room, "rotation", room.rotation + Vector3(0, 1.57, 0), rotation_speed)
		if abs(rotation_tracker) < 3:
			rotation_tracker +=1
		else:
			rotation_tracker = 0
		tween.tween_callback(tween_finished)
		check_walls()
		print(rotation_tracker)
		
	elif Input.is_action_just_pressed("rotate_right") and tween == null:
		#print("rotate right")
		sfx_rotate.play()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(room, "rotation", room.rotation + Vector3(0, -1.57, 0), rotation_speed)
		if abs(rotation_tracker) < 3:
			rotation_tracker -=1
		else:
			rotation_tracker = 0
		tween.tween_callback(tween_finished)
		check_walls()
		print(rotation_tracker)

#This hides and shows walls according to the rotation of the environment
func check_walls():
	match rotation_tracker:
		0:
			book_collision.visible = true
			tween_2 = create_tween()
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
		1:
			tween_2 = create_tween()
			book_collision.visible = false
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
		2:
			tween_2 = create_tween()
			book_collision.visible = false
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
		3:
			tween_2 = create_tween()
			book_collision.visible = true
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
		-1:
			tween_2 = create_tween()
			book_collision.visible = true
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
		-2:
			tween_2 = create_tween()
			book_collision.visible = false
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
		-3:
			book_collision.visible = false
			tween_2 = create_tween()
			for mesh in wall_1_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)
			for mesh in wall_2_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_3_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 0.0, wall_fade_speed)
			for mesh in wall_4_meshes:
				tween_2.parallel().tween_property(mesh, "transparency", 1.0, wall_fade_speed)


#func zoom_environment(delta):
	#if Input.is_action_just_pressed("zoom_in"):
		#zoomTarget += 1
	#elif Input.is_action_just_pressed("zoom_out"):
		#zoomTarget -= 1
	#camera_3d.size = zoomTarget.slerp(zoomTarget, zoomSpeed * delta)

func tween_finished():
	tween = null;
	
#This  
func pan_camera():
	
	pass
	
func get_move_vectors():
	pass

func water_bottle_clicked():
	if GameManager.interacted_stickers == true:
		water_bottle_state_1.visible = false;
		water_bottle_state_2.visible = true;
		
func water_bottle_stickers_clicked():
	print("world state water bottle stickers clicked")
	water_bottle_state_2.visible = false;
	
func big_plant_clicked():
	pass
	
func smol_plant_clicked():
	pass
	
func smol_plant_watered():
	plant_state_1.visible = false
	plant_state_2.visible = true
	
func journal_clicked():
	journal_state_1.visible = false
	journal_state_2.visible = true
	
func sticky_notes_clicked():
	pass
	
func stickers_clicked():
	sticker_sheets.visible = false
	
func sock_clicked():
	sock.visible = false
	pass
