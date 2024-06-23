extends Node3D

# track special objects that will change here
@onready var water_bottle_state_1 = $"Interactables/water bottle plain"
@onready var water_bottle_state_2 = $"Interactables/water bottle with stickers"

# Called when the node enters the scene tree for the first time.
func _ready():
	# let the GameManager have a reference to this so that it can control
	# nodes within this scene
	GameManager.World1RootNode = self;
	
func water_bottle_clicked():
	water_bottle_state_1.visible = false;
	water_bottle_state_2.visible = true;
