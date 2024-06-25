extends Node

@onready var dialogue_sfx = load("res://audio/sfx/maximize_008.ogg")

var current_passage: PackedInt32Array = [];
var cursor: int = -1; # -1 means that we don't have any dialogue loaded to be shown i.e. dialogue is hidden

var DIALOGUE_LAYER: CanvasLayer = null;
var audio_stream = null

func _ready():
	audio_stream = AudioStreamPlayer.new();
	audio_stream.set_stream(dialogue_sfx)
	audio_stream.volume_db = -20
	audio_stream.pitch_scale = 1.0
	add_child(audio_stream)

func OpenDialogueAndPauseGame(text_indices: PackedInt32Array):
	DIALOGUE_LAYER.stop_mouse_inputs();
	# wait 1 second for sparkles to play
	await get_tree().create_timer(1).timeout
	audio_stream.play()
	current_passage = text_indices;
	cursor = 0;
	DIALOGUE_LAYER.show_dialogue_ui(AllTheText.RESOURCES[current_passage[cursor]]);
	
func NextPassage():
	# all done reading, back to gameplay and check if epilogue is ready to initiate
	if (cursor + 1 >= current_passage.size() and DIALOGUE_LAYER.can_read_next_passage()):
		DIALOGUE_LAYER.hide_dialogue_ui();
		cursor = -1;
		GameManager.check_epilogue()
	# if the text is done animating
	elif (DIALOGUE_LAYER.can_read_next_passage()):
		cursor += 1;
		DIALOGUE_LAYER.next_passage(AllTheText.RESOURCES[current_passage[cursor]]);
	# move onto the next animation
	elif (DIALOGUE_LAYER.is_dialogue_shown()):
		DIALOGUE_LAYER.skip_text_animation();
		
func PreviousPassage():
	if (cursor - 1 >= 0 and DIALOGUE_LAYER.can_read_next_passage()):
		cursor -= 1;
		DIALOGUE_LAYER.next_passage(AllTheText.RESOURCES[current_passage[cursor]]);
	elif (DIALOGUE_LAYER.is_dialogue_shown()):
		DIALOGUE_LAYER.skip_text_animation();

func _process(delta):
	if (Input.is_action_just_pressed("ui_advance_dialogue") and cursor != -1):
		NextPassage();
	if (Input.is_action_just_pressed("ui_previous_dialogue") and cursor != -1):
		PreviousPassage();
