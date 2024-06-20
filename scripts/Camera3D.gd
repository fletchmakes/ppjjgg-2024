extends Camera3D
#since there is no physical player character this is basically our player script I suppose?
var cursor = preload("res://art/cursors/hand_thin_small_point.png")
var cursor_interactable = preload("res://art/cursors/hand_thin_small_open.png")
var cursor_dialogue = preload("res://art/cursors/message_dots_square.png")

var tween

#These keep the camera from getting too zoomed in or zoomed out
var size_min := 1
var size_max := 4

#Speed at which the camera zooms in and out
var zoom_speed := 0.1

func _ready():
	pass 

func _process(delta):
	if Input.is_action_just_pressed("zoom_in") and size > size_min:
		tween = create_tween()
		#tween.set_trans(Tween.TRANS_QUAD)
		#tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($".", "size", size - 1, zoom_speed)
		#size = size - 1
	elif Input.is_action_just_pressed("zoom_out") and size < size_max:
		tween = create_tween()
		#tween.set_trans(Tween.TRANS_QUINT)
		#tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($".", "size", size + 1, zoom_speed)
		#size = size + 1

#Signal connections for Sprite3D test object
#Highlights interactable objects when moused over
func _on_interactable_mouse_entered():
	#show highlight outline
	$"../../Sprite3D/Interactable/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_interactable,Input.CURSOR_ARROW,Vector2(16, 16))
#Unhighlights interactable objects when no longer moused over
func _on_interactable_mouse_exited():
	#hide highlight outline
	$"../../Sprite3D/Interactable/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16, 16))
#Plays dialogue when moused over and clicked
func _on_interactable_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(16, 16))
		DialogueManager.OpenDialogueAndPauseGame([4, 1, 2])
		GameManager.ResetYawnTimer()
		


#Signal connections for Object1
func _on_object_1_mouse_entered():
	$"../../Interactables/Object1/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_interactable,Input.CURSOR_ARROW,Vector2(16, 16))
	
func _on_object_1_mouse_exited():
	$"../../Interactables/Object1/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16, 16))

func _on_object_1_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(16, 16))
		DialogueManager.OpenDialogueAndPauseGame([5])
		GameManager.ResetYawnTimer()

#Signal connections for Object2
func _on_object_2_mouse_entered():
	$"../../Interactables/Object2/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_interactable,Input.CURSOR_ARROW,Vector2(16, 16))

func _on_object_2_mouse_exited():
	$"../../Interactables/Object2/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16, 16))

func _on_object_2_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(16, 16))
		DialogueManager.OpenDialogueAndPauseGame([6])
		GameManager.ResetYawnTimer()

#Signal connections for Object3
func _on_object_3_mouse_entered():
	$"../../Interactables/Object3/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_interactable,Input.CURSOR_ARROW,Vector2(16, 16))

func _on_object_3_mouse_exited():
	$"../../Interactables/Object3/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16, 16))

func _on_object_3_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(16, 16))
		DialogueManager.OpenDialogueAndPauseGame([7])
		GameManager.ResetYawnTimer()
