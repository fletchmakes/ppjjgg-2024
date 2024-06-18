extends CanvasLayer

@onready var DialogueUI = $DialogueUI;
@onready var DialogueText = $DialogueUI/MarginContainer/CenterContainer/RichTextLabel;
@onready var DialogueNextIndicator = $DialogueUI/MarginContainer/AspectRatioContainer/NextArrow;

var display_state = "hidden";
var text_state = "ready";

var text_speed = 0.5;

func _ready():
	DialogueManager.DIALOGUE_LAYER = self;

func _process(delta):
	# next arrow indicator
	if (self.can_read_next_passage()):
		DialogueNextIndicator.show();
	else:
		DialogueNextIndicator.hide();
	
	# animating the dialogue window in and out
	if (display_state == "hiding"):
		var current_modulate: Color = DialogueUI.get_modulate();
		var current_alpha = current_modulate.a;
		var next_alpha = lerp(current_alpha, 0.0, 0.1);
		if (next_alpha - 0 < 0.05):
			self.display_state = "hidden";
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, 0));
			# TODO: stop capturing input events
		else:
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, next_alpha));
			
	if (display_state == "showing"):
		var current_modulate: Color = DialogueUI.get_modulate();
		var current_alpha = current_modulate.a;
		var next_alpha = lerp(current_alpha, 1.0, 0.1);
		if (1 - next_alpha < 0.05):
			self.display_state = "shown";
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, 1));
			# TODO: start capturing input events
		else:
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, next_alpha));

	# animating the text
	if (self.text_state == "animating" and self.display_state == "shown"):
		DialogueText.visible_ratio += 0.05 * text_speed;
		if (DialogueText.visible_ratio >= 1.0):
			self.text_state = "ready";
			DialogueText.visible_ratio = 1.0;

func hide_dialogue_ui():
	self.display_state = "hiding";
	
func show_dialogue_ui(text: String):
	self.display_state = "showing";
	DialogueText.text = text;
	DialogueText.visible_ratio = 0.0;
	self.text_state = "animating";
	
# returns whether or not we successfully made it to the next passage
func next_passage(text: String):
	self.text_state = "animating";
	DialogueText.text = text;
	DialogueText.visible_ratio = 0.0;

# allows other classes to ask if the dialogue layer is ready to proceed to the next page
func can_read_next_passage():
	return text_state == "ready";

func skip_text_animation():
	self.text_state = "ready";
	DialogueText.visible_ratio = 1.0;
