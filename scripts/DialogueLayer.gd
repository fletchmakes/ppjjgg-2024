extends CanvasLayer

@onready var DialogueUI = $DialogueUI;
@onready var DialogueText = $DialogueUI/MarginContainer/MarginContainer/RichTextLabel;
@onready var DialogueNextIndicator = $DialogueUI/MarginContainer/AspectRatioContainer/NextArrow;

var display_state = "hidden";
var text_state = "ready";

@export_range(0.01, 0.05) var text_speed: float = 0.01;
var delta_accumulator: float = 0.0;

func _ready():
	DialogueManager.DIALOGUE_LAYER = self;
	hide_dialogue_ui();

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
			DialogueUI.mouse_filter = 2; # MOUSE_FILTER_IGNORE
		else:
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, next_alpha));
			
	if (display_state == "showing"):
		var current_modulate: Color = DialogueUI.get_modulate();
		var current_alpha = current_modulate.a;
		var next_alpha = lerp(current_alpha, 1.0, 0.1);
		if (1 - next_alpha < 0.05):
			self.display_state = "shown";
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, 1));
		else:
			DialogueUI.set_modulate(Color(current_modulate.r, current_modulate.g, current_modulate.b, next_alpha));

	# animating the text
	if (self.text_state == "animating" and self.display_state == "shown"):
		self.delta_accumulator += delta*10;
		if (self.delta_accumulator >= text_speed):
			self.delta_accumulator = 0.0;
			DialogueText.visible_characters += 1;
		if (DialogueText.visible_characters == DialogueText.text.length()):
			self.text_state = "ready";
			DialogueText.visible_characters = -1;

func hide_dialogue_ui():
	self.display_state = "hiding";
	
func show_dialogue_ui(text: String):
	DialogueUI.mouse_filter = 0; # MOUSE_FILTER_STOP
	self.display_state = "showing";
	self.text_state = "animating";
	DialogueText.text = text;
	DialogueText.visible_characters = 0;
	
func is_dialogue_shown():
	return self.display_state == "shown";
	
# returns whether or not we successfully made it to the next passage
func next_passage(text: String):
	self.text_state = "animating";
	DialogueText.text = text;
	DialogueText.visible_characters = 0;

# allows other classes to ask if the dialogue layer is ready to proceed to the next page
func can_read_next_passage():
	return text_state == "ready";

func skip_text_animation():
	self.text_state = "ready";
	DialogueText.visible_characters = -1;
