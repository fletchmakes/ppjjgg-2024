extends Node

var yawn_timer = null;
var audio_stream = null;

@onready var yawn_resource = load("res://audio/yawn1.mp3");

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
	
