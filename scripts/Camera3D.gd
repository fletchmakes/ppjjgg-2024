extends Camera3D
#since there is no physical player character this is basically our player script I suppose?
@onready var sfx_interactables = GameManager.SFXInteractablesPlayer;

var cursor = preload("res://art/cursors/hand_thin_small_point.png")
var cursor_interactable = preload("res://art/cursors/hand_thin_small_open.png")
var cursor_eye = preload("res://art/cursors/look_c.png")
var cursor_dialogue = preload("res://art/cursors/message_dots_square.png")

var tween

#These keep the camera from getting too zoomed in or zoomed out
var size_min := 1
var size_max := 5

#Speed at which the camera zooms in and out
var zoom_speed := 0.1

#Testing for little animation when object is clicked on
var sprite3d_position

#Keeps track of whether an object has been interacted with at least once
var interacted_big_plant := false
var interacted_journal  := false
var interacted_smol_plant  := false
var interacted_water_bottle  := false
var interacted_sticky_notes  := false
var interacted_phone  := false
var interacted_pen  := false
var interacted_bin  := false
var interacted_stickers  := false

func _ready():
	#sprite3d_position = $"../../Sprite3D".position
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

func objectInteracted(object_number : int):
	var variable = object_number
	match variable:
		1:
			var interacted_big_plant = true
		2:
			var interacted_journal = true
		3:
			var interacted_smol_plant = true
		4:
			var interacted_water_bottle = true
		5:
			var interacted_sticky_notes = true
		6:
			var interacted_phone = true
		7:
			var interacted_pen = true
		8:
			var interacted_bin = true
		_:
			pass

func _check_completion():
	if interacted_big_plant and interacted_journal and interacted_smol_plant and interacted_water_bottle and interacted_sticky_notes and interacted_phone and interacted_pen and interacted_bin == true:
		#Play epilogue dialogue if all objects have been found
		sfx_interactables.play()
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([2])
		GameManager.ResetYawnTimer()
		pass
	pass

#Signal connections for Sprite3D test object
#Highlights interactable objects when moused over
func _on_interactable_mouse_entered():
	$"../../Sprite3D/Interactable/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
#Unhighlights interactable objects when no longer moused over
func _on_interactable_mouse_exited():
	$"../../Sprite3D/Interactable/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
#Plays dialogue when moused over and clicked
func _on_interactable_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BOUNCE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($"../../Sprite3D", "position", sprite3d_position + Vector3(0, 0.02, 0), zoom_speed)
		tween.tween_property($"../../Sprite3D", "position", sprite3d_position, zoom_speed)
		sfx_interactables.play()
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([3, 1])
		GameManager.ResetYawnTimer()

#Signal connections for Object1
func _on_object_1_mouse_entered():
	$"../../Interactables/Object1/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_1_mouse_exited():
	$"../../Interactables/Object1/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_1_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BOUNCE)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($"../../Sprite3D", "position", sprite3d_position + Vector3(0, 0.02, 0), zoom_speed)
		tween.tween_property($"../../Sprite3D", "position", sprite3d_position, zoom_speed)
		sfx_interactables.play()
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([4])
		GameManager.ResetYawnTimer()

#Signal connections for Object2
func _on_object_2_mouse_entered():
	$"../../Interactables/Object2/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_2_mouse_exited():
	$"../../Interactables/Object2/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_2_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([5])
		GameManager.ResetYawnTimer()

#Signal connections for Object3
func _on_object_3_mouse_entered():
	$"../../Interactables/Object3/MeshInstance3D/Outline".visible = true
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_3_mouse_exited():
	$"../../Interactables/Object3/MeshInstance3D/Outline".visible = false
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_object_3_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([6])
		GameManager.ResetYawnTimer()

#journal (closed version)
func _on_interactable_journal_closed_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_journal_closed_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_journal_closed_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_journal  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([7])
		GameManager.ResetYawnTimer()

#water bottle (plain)
func _on_interactable_waterbottle_plain_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_waterbottle_plain_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_waterbottle_plain_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_water_bottle  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([8])
		GameManager.ResetYawnTimer()
		# Let the game know that the water bottle was clicked
		GameManager.click_water_bottle()

#pen
func _on_interactable_pen_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_pen_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_pen_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_pen  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([9])
		GameManager.ResetYawnTimer()

#phone
func _on_interactable_phone_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_phone_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_phone_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_phone  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([10])
		GameManager.ResetYawnTimer()

#stickynotes
func _on_interactable_stickynotes_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_stickynotes_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_stickynotes_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_sticky_notes  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([11, 12, 13])
		GameManager.ResetYawnTimer()

#bin with paper
func _on_interactable_bin_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_bin_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_bin_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_bin  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([14])
		GameManager.ResetYawnTimer()

#sticker sheet
func _on_interactable_stickers_mouse_entered():
	Input.set_custom_mouse_cursor(cursor_eye,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_stickers_mouse_exited():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(0, 0))
func _on_interactable_stickers_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		interacted_stickers  = true
		Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([15])
		GameManager.ResetYawnTimer()



#Books with minor flavor text
#It's Only A Game
func _on_its_only_a_game_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([16])
		GameManager.ResetYawnTimer()
#Frog and Cloud
func _on_frogandcloud_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([17])
		GameManager.ResetYawnTimer()
#The Speed Cat
func _on_thespeedcat_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([18])
		GameManager.ResetYawnTimer()
#The Sprout
func _on_thesprout_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([19])
		GameManager.ResetYawnTimer()
#Gender Magic
func _on_gendermagic_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([20])
		GameManager.ResetYawnTimer()
#Circe
func _on_circe_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([21])
		GameManager.ResetYawnTimer()
#Fool's Fate
func _on_foolsfate_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([22])
		GameManager.ResetYawnTimer()
#The Happy Place
func _on_thehappyplace_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([23])
		GameManager.ResetYawnTimer()
#Everything I Wanted
func _on_everythingiwanted_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([24])
		GameManager.ResetYawnTimer()
#Spooky Carvings and Other Stories
func _on_spookycarvingsandotherstories_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([25])
		GameManager.ResetYawnTimer()
#Matcha, a Love Story
func _on_matchaalovestory_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([26])
		GameManager.ResetYawnTimer()
#The Munch Kitteers
func _on_themunchkitteers_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([27])
		GameManager.ResetYawnTimer()
#Ducks Love Boba
func _on_ducksloveboba_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([28])
		GameManager.ResetYawnTimer()
#Corner of the Room
func _on_corneroftheroom_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([29])
		GameManager.ResetYawnTimer()
#Celestially, Yours
func _on_celestiallyyours_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([30])
		GameManager.ResetYawnTimer()
#Space Cafe
func _on_spacecafe_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([31])
		GameManager.ResetYawnTimer()
#How to Train Your Cat
func _on_howtotrainyourcat_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([32])
		GameManager.ResetYawnTimer()
#The Missing Sock
func _on_themissingsock_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([33])
		GameManager.ResetYawnTimer()
#October Country
func _on_octobercountry_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([34])
		GameManager.ResetYawnTimer()
#Quack, the Secrets of a Mastermind
func _on_quackthesecretsofamastermind_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([35])
		GameManager.ResetYawnTimer()
#So Many Scarves
func _on_somanyscarves_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([36])
		GameManager.ResetYawnTimer()
#Cheesecakes
func _on_cheesecakes_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([37])
		GameManager.ResetYawnTimer()
#Ayla's Adventures
func _on_alyasadventures_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([38])
		GameManager.ResetYawnTimer()
#The Moon and her Man
func _on_themoonandherman_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([39])
		GameManager.ResetYawnTimer()
#The Sea in Cerise
func _on_theseaincerise_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([40])
		GameManager.ResetYawnTimer()
#Almost Everything
func _on_almosteverything_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([41])
		GameManager.ResetYawnTimer()
#Cats in Wizard Caps
func _on_catsinwizardcaps_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([42])
		GameManager.ResetYawnTimer()
#Here Hold my Fish
func _on_hereholdmyfish_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([43])
		GameManager.ResetYawnTimer()
#The Tism Rizz
func _on_thetismrizz_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([44])
		GameManager.ResetYawnTimer()
#I'm a Little Brain-Spicy
func _on_imalittlebrainspicy_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		sfx_interactables.play()
		#Input.set_custom_mouse_cursor(cursor_dialogue,Input.CURSOR_ARROW,Vector2(0, 0))
		DialogueManager.OpenDialogueAndPauseGame([45])
		GameManager.ResetYawnTimer()
