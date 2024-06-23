extends Node

# references to other nodes
var SFXInteractablesPlayer = null;

# get a reference to World 1 (and later on, World 2) root nodes so that 
# we can manipulate objects within them later
# World 1 has a script attached to it that will bind this variable
# to itself on _ready();
var World1RootNode = null;
var World2RootNode = null;

# ------------------------------
# START GAME STATE TRACKING EXAMPLE
@onready var interacted_big_plant := false
@onready var interacted_journal  := false
@onready var interacted_smol_plant  := false
@onready var interacted_water_bottle  := false
@onready var interacted_sticky_notes  := false
@onready var interacted_phone  := false
@onready var interacted_pen  := false
@onready var interacted_bin  := false

func click_water_bottle():
	interacted_water_bottle = true;
	World1RootNode.water_bottle_clicked();
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
	audio_stream.set_stream(yawn_resource);
	add_child(audio_stream);
	
func ResetYawnTimer():
	yawn_timer.stop();
	yawn_timer.start();
	
func _on_timer_timeout():
	audio_stream.play();
	DialogueManager.OpenDialogueAndPauseGame([0]);
	ResetYawnTimer();
	
