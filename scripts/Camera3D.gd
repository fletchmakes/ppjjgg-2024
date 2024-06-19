extends Camera3D
#since there is no physical player character this is basically our player script I suppose?
var cursor = preload("res://art/cursors/hand_thin_small_point.png")
var cursor_interactable = preload("res://art/cursors/hand_thin_small_open.png")
var cursor_dialogue = preload("res://art/cursors/message_dots_square.png")

func _ready():
	pass 

func _process(delta):
	pass

#Highlights interactable objects when moused over
func _on_interactable_mouse_entered():
	print("highlight")
	#show highlight outline
	$"../Sprite3D/Interactable/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_interactable,Input.CURSOR_ARROW,Vector2(16, 16))


#Unhighlights interactable objects when no longer moused over
func _on_interactable_mouse_exited():
	print("unhighlight")
	#hide highlight outline
	$"../Sprite3D/Interactable/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(16, 16))


#Plays dialogue when moused over and clicked
func _on_interactable_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(16, 16))
		DialogueManager.OpenDialogueAndPauseGame([4])

