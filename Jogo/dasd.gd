extends CharacterBody2D

var velocidade = 15
var nickname = ""
var camera
#var player_camera: Camera2D

func _ready():
	#camera = get_node("Camera2D")
	pass
	
func _process(delta):
	if is_multiplayer_authority():
		var axys = Vector2.ZERO
		if Input.is_action_pressed("b_direita"):
			$AnimatedSprite2D.play("andar")
			$AnimatedSprite2D.flip_h = false
			axys += Vector2(1, 0)
		elif Input.is_action_pressed("b_esquerda"):
			$AnimatedSprite2D.play("andar")
			$AnimatedSprite2D.flip_h = true			
			axys += Vector2(-1, 0)
		elif Input.is_action_pressed("b_cima"):
			$AnimatedSprite2D.play("subir")
			axys += Vector2(0, -1)
		elif Input.is_action_pressed("b_baixo"):
			$AnimatedSprite2D.play("descer")
			axys += Vector2(0, 1)
		else:
			$AnimatedSprite2D.play("idle")
		position += axys * velocidade * delta * 20

	#if player_camera != null:
		#camera.current = player_camera

func set_nickname(nickname):
	self.nickname = nickname
	$NicknameLabel.text = nickname
