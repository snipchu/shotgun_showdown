extends Node3D
const birdyscene = preload("res://scenes/birdy.tscn")
var score := 0
var ammo := 10;
var ammobank = 30;
var started := false;
var ended := false;

func _ready() -> void:
	randomize()
	signalbus.bird_hit.connect(add_point)
	signalbus.shoot.connect(shoot)
	signalbus.restartgame.connect(add_point)
	signalbus.endgame.connect(shoot)

func _process(_delta: float) -> void:
	if (!ended):
		$HUD/timer.text = str(floor($gamelength.time_left)) if (started) else str(20)
		$HUD/bigtext.text = str(floor($countdown.time_left)) if floor($countdown.time_left)!=0 else "START"
	else:
		end_game()

func _on_countdown_timeout() -> void:
	signalbus.game_started.emit()
	started = true;
	$HUD/timer.visible = true
	$HUD/bigtext.visible = false
	$gamelength.start()
func _on_gamelength_timeout() -> void: end_game()
func end_game() -> void:
	ended=true
	$HUD3D.visible = true
	$HUD3D/restartbutton/CollisionShape3D.disabled = false
	$HUD3D/endbutton/CollisionShape3D.disabled = false
	$HUD3D/score.text = "score: "+str(score)
	signalbus.game_ended.emit()
	$bird_spawn.stop()
func canshoot(): return ammobank>0 || ammo>0
func ingame(): return started && !ended

func shoot():
	if (ammo>0):
		ammo -= 1
	else:
		ammobank -= 10
		ammo = 10
	$HUD/ammo.text = str(ammo)+" - "+str(ammobank)
func add_point(points):
	score += points
	$HUD/score.text = str(score)
func _on_bird_spawn_timeout() -> void:
	var birdy = birdyscene.instantiate()
	birdy.flipacoin()
	birdy.position.z = -10+(randf()*5)
	birdy.position.y = randf_range(0,3)
	birdy.position.x = -8 if (birdy.get_coin()==1) else 8
	add_child(birdy)
