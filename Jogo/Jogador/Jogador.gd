extends CharacterBody2D

const velocidade = 300
var nickname = ""
var camera

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	if is_multiplayer_authority():
		if Input.is_action_pressed("b_direita"):
			$AnimatedSprite2D.play("andar")
			$AnimatedSprite2D.flip_h = false
			input_vector.x += 1
		elif Input.is_action_pressed("b_esquerda"):
			$AnimatedSprite2D.play("andar")
			$AnimatedSprite2D.flip_h = true
			input_vector.x -= 1
		elif Input.is_action_pressed("b_cima"):
			$AnimatedSprite2D.play("subir")
			input_vector.y -= 1
		elif Input.is_action_pressed("b_baixo"):
			$AnimatedSprite2D.play("descer")
			input_vector.y += 1
			
		if input_vector != Vector2.ZERO:
			input_vector = input_vector.normalized()
			velocity = input_vector * velocidade
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("idle")
			
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = Vector2.ZERO
			
func set_nickname(nickname):
	self.nickname = nickname
	$NicknameLabel.text = nickname
