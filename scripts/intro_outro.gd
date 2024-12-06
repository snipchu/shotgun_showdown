extends CanvasLayer

var introdialog = [
	"Let's go camping",
	"Filler text Intro 2",
	"Filler text Intro 3"
]
var dialogindex = 0;

func _ready() -> void: nextline()
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		nextline()
		dialogindex+=1

func nextline():
	if (dialogindex<introdialog.size()):
		$box/text_dialogue.text = introdialog[dialogindex]
	else:
		get_tree().change_scene_to_file("res://scenes/world.tscn")
