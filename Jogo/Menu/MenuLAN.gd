extends Control

func _ready():
	Networking.lista_alterada.connect(self.lista_alterada)
	Networking.conexao_resetada.connect(self.conexao_resetada)
	pass

func _on_criar_pressed():
	Networking.atualizar_nome($Nome.text)
	Networking.criar_servidor()
	$Criar.disabled = true
	$Conectar.disabled = true
	pass

func _on_conectar_pressed():
	Networking.atualizar_ip($IP.text)
	Networking.atualizar_nome($Nome.text)
	Networking.entrar_servidor()
	$Criar.disabled = true
	$Conectar.disabled = true
	pass

func _on_comecar_pressed():
	if multiplayer.is_server():
		rpc("comecar_jogo")
	pass

@rpc("any_peer", "call_local")
func comecar_jogo():
	get_tree().change_scene_to_file("res://Jogo/Fase/Fase.tscn")
	pass

func lista_alterada():
	var lista = Networking.retornar_lista()
	$ListaJogadores.clear()
	for i in range(lista.size()):
		if lista[i][0] == Networking.id:
			$ListaJogadores.add_item(lista[i][1] + str(" (você)"))
		else:
			$ListaJogadores.add_item(lista[i][1])
	pass
pass

func conexao_resetada():
	$Erro.show()
	pass

func _on_erropanel_button_pressed():
	$Criar.disabled = false
	$Conectar.disabled = false
	$ErroPanel.hide()
	pass
