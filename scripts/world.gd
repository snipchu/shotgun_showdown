extends WorldEnvironment
const birdyscene = preload("res://scenes/birdy.tscn")
var score := 0
var ammo := 10
var ammobank = 30
var started := false
var ended := false

func _ready() -> void:
	randomize()
	signalbus.bird_hit.connect(add_point)
	signalbus.miss_shot.connect(miss_shot)
	signalbus.reload.connect(reload)
	
func _process(_delta: float) -> void:
	if (!ended && ammo+ammobank>0):
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
	signalbus.game_ended.emit()
	$bird_spawn.stop()
	$HUD3D/restartbutton/CollisionShape3D.disabled = false
	$HUD3D/endbutton/CollisionShape3D.disabled = false
	$HUD3D.visible = true
	$HUD3D/score.text = "score: "+str(score)
	if (score>=30):
		$HUD3D/result.text = "You did great"
		$HUD3D/resultimg.texture = load("res://assets/bruce_great.png")
	elif (score>20):
		$HUD3D/result.text = "You did good"
		$HUD3D/resultimg.texture = load("res://assets/bruce_good.png")
	else:
		$HUD3D/result.text = "You did okay"
		$HUD3D/resultimg.texture = load("res://assets/bruce_okay.png")

func canshoot(): return ammobank>=0 && ammo>0
func ingame(): return started && !ended
func shoot():
	ammo -= 1
	$gun_sfx.play()
	$HUD/ammo.text = str(ammo)+" - "+str(ammobank)
func reload():
	$gun_sfx.stream = preload("res://assets/31701__lumikon__shotgun-sfx/564482__lumikon__shotgun-reload-sfx.wav")
	$gun_sfx.play()
	$HUD/brucegun/anim.play("reload")
	ammobank -= 10
	ammo = 10
func miss_shot():
	shoot()
	$HUD/brucegun/anim.play("shoot")
	$gun_sfx.stream = preload("res://assets/31701__lumikon__shotgun-sfx/564480__lumikon__shotgun-shot-sfx.wav")
	$gun_sfx.play()
func add_point(points):
	shoot()
	$gun_sfx.stream = preload("res://assets/31701__lumikon__shotgun-sfx/564483__lumikon__shotgun-hit.wav")
	$gun_sfx.play()
	score += points
	$HUD/score.text = str(score)
	$HUD/brucegun/anim.play("shoot")
func _on_bird_spawn_timeout() -> void:
	var birdy = birdyscene.instantiate()
	birdy.flipacoin()
	birdy.position.z = -10+(randf()*5)
	birdy.position.y = randf_range(0,3)
	birdy.position.x = -8 if (birdy.get_coin()==1) else 8
	add_child(birdy)
