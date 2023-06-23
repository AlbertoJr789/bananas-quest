extends Control

func _ready():
	Network.Menu = self
	pass
	
func _on_criar_button_down():
	Network.Mudar_Ip($ip.text)
	Network.Mudar_Nome($nome.text)
	Network.Criar()
	pass

func _on_entrar_button_down():
	Network.Mudar_Ip($ip.text)
	Network.Mudar_Nome($nome.text)
	Network.Entrar()
	pass

func Atualizar_Lista_Jogadores():
	var Lista = Network.Pegar_Lista_Jogadores()
	var Id = Network.Pegar_Identificador()
	var Num = Network.Pegar_Numero_Jogadores()
	$jogadoresLista.clear()
	for i in range(Num):
		if Lista[i][0] == Id:
			$jogadoresLista.add_item(str(Lista[i][1]) + str(" (você)"))
		else:
			$jogadoresLista.add_item(Lista[i][1])
	pass
