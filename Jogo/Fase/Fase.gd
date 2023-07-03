extends Node2D

var packed_jogador = preload("res://Jogo/Jogador/Jogador.tscn")
var jogador_positions = []  # Lista para armazenar as posições dos jogadores

func _ready():
	var lista_jogadores = Networking.retornar_lista()
	for i in range(lista_jogadores.size()):
		var obj = packed_jogador.instantiate()
		$Jogadores.add_child(obj)
		var position = get_random_position()
		jogador_positions.append(position)
		obj.position = position
		obj.name = str(lista_jogadores[i][0])
		obj.set_multiplayer_authority(lista_jogadores[i][0])
		obj.set_nickname(lista_jogadores[i][1])

func get_random_position():
	var valid_position = false
	var position = Vector2()
	while not valid_position:
		position = Vector2(randf_range(100, 900), randf_range(100, 500))  # Defina o intervalo de posições desejado
		valid_position = true
		for i in range(jogador_positions.size()):
			if jogador_positions[i].distance_to(position) < 100:  # Ajuste o valor de distância mínima entre jogadores
				valid_position = false
				break
	return position

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var jogador = body as Node2D
	print("O objeto ", jogador.name, " entrou na área")
