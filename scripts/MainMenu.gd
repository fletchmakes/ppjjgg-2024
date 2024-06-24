extends Control
@onready var sfx_menu_button = $SFXMenuButton

var display_state = "shown";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.display_state == "hiding"):
		var current_modulate: Color = self.get_modulate();
		var current_alpha = current_modulate.a;
		var next_alpha = lerp(current_alpha, 0.0, 0.1);
		if (next_alpha - 0 < 0.05):
			GameManager.ResetYawnTimer();
			self.queue_free();
		else:
			self.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, next_alpha));
			

func _on_play_button_pressed():
	sfx_menu_button.play()
	self.display_state = "hiding";
	DialogueManager.OpenDialogueAndPauseGame([48, 49, 50])
