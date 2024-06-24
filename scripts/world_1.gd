extends Node3D

# track special objects that will change here
@onready var water_bottle_state_1 = $"Environment/Interactables/water bottle plain"
@onready var water_bottle_state_2 = $"Environment/Interactables/water bottle with stickers"
@onready var journal_state_1 = $"Environment/Interactables/journal-closed"
@onready var journal_state_2 = $"Environment/Interactables/journal-open2"
@onready var sticker_sheets = $"Environment/Interactables/sticker sheets"
@onready var plant_state_1 = $"Environment/Interactables/smol plant"
@onready var plant_state_2 = $"Environment/Interactables/big plant"

@onready var camera_3d = $Pivot/Camera3D

var zoomTarget
var zoomSpeed := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	zoomTarget = camera_3d.size
	# let the GameManager have a reference to this so that it can control
	# nodes within this scene
	GameManager.World1RootNode = self;

func _process(delta):
	#zoom_environment(delta)
	pass
	
func rotate_environment():
	#if Input.is_action_just_pressed("rotate_left") and tween == null:
		##print("rotate left")
		#sfx_rotate.play()
		#tween = create_tween()
		#tween.set_trans(Tween.TRANS_BACK)
		#tween.set_ease(Tween.EASE_IN_OUT)
		#tween.tween_property($".", "rotation", rotation + Vector3(0, 1.57, 0), rotation_speed)
		#tween.tween_callback(tween_finished)
		#
	#elif Input.is_action_just_pressed("rotate_right") and tween == null:
		##print("rotate right")
		#sfx_rotate.play()
		#tween = create_tween()
		#tween.set_trans(Tween.TRANS_BACK)
		#tween.set_ease(Tween.EASE_IN_OUT)
		#tween.tween_property($".", "rotation", rotation + Vector3(0, -1.57, 0), rotation_speed)
		#tween.tween_callback(tween_finished)
	pass
	
#func zoom_environment(delta):
	#if Input.is_action_just_pressed("zoom_in"):
		#zoomTarget += 1
	#elif Input.is_action_just_pressed("zoom_out"):
		#zoomTarget -= 1
	#camera_3d.size = zoomTarget.slerp(zoomTarget, zoomSpeed * delta)

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
	
func phone_clicked():
	pass
	
func pen_clicked():
	pass
	
func bin_clicked():
	pass
	
func stickers_clicked():
	sticker_sheets.visible = false

