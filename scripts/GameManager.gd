extends Node

# references to other nodes
var SFXInteractablesPlayer = null;

# get a reference to World 1 (and later on, World 2) root nodes so that 
# we can manipulate objects within them later
# World 1 has a script attached to it that will bind this variable
# to itself on _ready();
var World1RootNode = null;
var World2RootNode = null;
var Camera = null

# sparkles stuff
@onready var sparkles = preload("res://scenes/sparkles.tscn")

# ------------------------------
# START GAME STATE TRACKING EXAMPLE
@onready var interacted_big_plant := false
@onready var interacted_journal  := false
@onready var interacted_smol_plant  := false
@onready var smol_plant_watered  := false
@onready var interacted_water_bottle  := false
@onready var interacted_water_bottle_stickers  := false
@onready var interacted_sticky_notes  := false
@onready var interacted_phone  := false
@onready var interacted_pen  := false
@onready var interacted_bin  := false
@onready var interacted_stickers  := false
@onready var interacted_sock := false

@onready var epilogue_played := false

func click_water_bottle():
	interacted_water_bottle = true;
	World1RootNode.water_bottle_clicked();
	create_sparkles()

func click_water_bottle_stickers():
	interacted_water_bottle_stickers = true;
	World1RootNode.water_bottle_stickers_clicked();
	create_sparkles()

func click_big_plant():
	interacted_big_plant = true
	World1RootNode.big_plant_clicked()
	create_sparkles()
	
func click_smol_plant():
	interacted_smol_plant = true
	World1RootNode.smol_plant_clicked()
	create_sparkles()

func click_smol_plant_water():
	smol_plant_watered = true
	World1RootNode.smol_plant_watered()
	create_sparkles()
	
func click_journal():
	interacted_journal = true
	World1RootNode.journal_clicked()
	create_sparkles()
	
func click_sticky_notes():
	interacted_sticky_notes = true
	World1RootNode.sticky_notes_clicked()
	create_sparkles()
	
func click_phone():
	interacted_phone = true
	#World1RootNode.phone_clicked() does not exist
	create_sparkles()

func click_stickers():
	interacted_stickers = true
	World1RootNode.stickers_clicked()
	create_sparkles()
	
func click_sock():
	interacted_sock = true
	World1RootNode.sock_clicked()
	create_sparkles()
	create_sparkles()
	create_sparkles()
	
func check_epilogue():
	#check that all the things have been interacted with + plant watered
	#I THINK what we need done is water bottle pasted with stickers, little plant watered, journal opened
	# and read, and sticky notes read
	# then we want to trigger phone call + epilogue text
	if (interacted_journal and interacted_water_bottle_stickers and interacted_sticky_notes and smol_plant_watered) == true:
		#do end game stuff
		Camera.start_epilogue()
		epilogue_played = true
	
# END GAME STATE TRACKING EXAMPLE
# ------------------------------

# yawn stuff
var yawn_timer = null;
var audio_stream = null;

@onready var yawn_resource = load("res://audio/sfx/yawn1.mp3");
# end yawn stuff

# Called when the node enters the scene tree for the first time.
func _ready():
	yawn_timer = Timer.new();
	yawn_timer.wait_time = 120.0; # 2 minutes / 120 seconds
	yawn_timer.connect("timeout", self._on_timer_timeout);
	add_child(yawn_timer);
	
	audio_stream = AudioStreamPlayer.new();
	audio_stream.set_stream(yawn_resource)
	audio_stream.volume_db = -20
	audio_stream.pitch_scale = 1.3
	add_child(audio_stream);
	
func ResetYawnTimer():
	yawn_timer.stop();
	yawn_timer.start();
	
func _on_timer_timeout():
	audio_stream.play();
	DialogueManager.OpenDialogueAndPauseGame([0]);
	ResetYawnTimer();
	
# https://www.youtube.com/watch?v=MuObpUUOdlo
func create_sparkles():
	var sparkles_instance: CPUParticles2D = sparkles.instantiate()
	sparkles_instance.global_position = get_viewport().get_mouse_position()
	add_child(sparkles_instance)
	sparkles_instance.emitting = true
	
