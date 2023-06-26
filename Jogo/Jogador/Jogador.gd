extends Node2D

var velocidade = 70
var nickname = ""
var camera
var player_camera: Camera2D

func _ready():
	camera = get_node("Camera2D")

func _process(delta):
	if is_multiplayer_authority():
		var axys = Vector2.ZERO
		if Input.is_action_pressed("b_direita"):
			axys += Vector2(1, 0)
		if Input.is_action_pressed("b_esquerda"):
			axys += Vector2(-1, 0)
		if Input.is_action_pressed("b_cima"):
			axys += Vector2(0, -1)
		if Input.is_action_pressed("b_baixo"):
			axys += Vector2(0, 1)
		position += axys * velocidade * delta * 20

	if player_camera != null:
		camera.current = player_camera

func set_nickname(nickname):
	self.nickname = nickname
	$NicknameLabel.text = nickname
