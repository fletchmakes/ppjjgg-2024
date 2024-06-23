extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GameManager.is_water_bottle_clicked):
		# do whatever behavior you'd like to do here
		self.visible = false;
