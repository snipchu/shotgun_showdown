extends CanvasLayer

var introdialog = [
	"Let's go camping",
	"I heard the woods has plenty of blue birds.",
	"Maybe there'll be some red ones too"
]
var dialogindex = 0;

func _ready() -> void: nextline()
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		nextline()
		dialogindex+=1

func nextline():
	if (dialogindex<introdialog.size()):
		$text_dialogue.text = introdialog[dialogindex]
	else:
		get_tree().change_scene_to_file("res://scenes/world.tscn")
