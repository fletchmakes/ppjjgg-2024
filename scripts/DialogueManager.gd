extends Node

var current_passage: PackedInt32Array = [];
var cursor: int = 0;

func OpenDialogueAndPauseGame(text_indices: PackedInt32Array):
	current_passage = text_indices;
	cursor = 0;
	# TODO: show the dialogue overlay & pause gameplay
	# TODO: print the first passage onto the screen
	# TODO: only DialogueManager can receive input events
	NextPassage();
	
func NextPassage():
	cursor += 1;
	if (cursor >= current_passage.size()):
		# TODO: close the dialogue and return control to the game
		pass;
	else:
		# TODO: animate out the current dialogue and animate in the next
		pass;
