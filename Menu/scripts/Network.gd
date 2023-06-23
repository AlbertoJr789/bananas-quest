extends Node2D

const IP_PADRAO = "127.0.0.1"
const PORTA_PADRAO = "8080"

var Ip = "127.0.0.1"
var Id = ""
var Nome = ""

var Peer = null
var Jogadores = []
var Numero_Jogadores = 0
var Menu = null

func _ready():
	get_tree().connect_to_node(self, "connected_to_server", "conectado_no_servidor")
	get_tree().connect_to_node(self, "connection_failed", "erro_de_conexao")
	get_tree().connect_to_node(self, "server_disconnected", "servidor_desconectado")
	pass

func conectado_no_servidor():
	rpc("Registrar_Jogador", get_tree().get_network_unique_id(), Nome)
	pass
	
func disconectado_do_servidor(id):
	var pos = 0
	for i in range(Numero_Jogadores):
		if Jogadores[i][0] == id:
			pos = i
	rpc("Remover_Jogador", pos)
	pass
	
func erro_de_conexao():
	pass
	
func servidor_desconectado():
	pass
	
func Registrar_Jogador(id ,novonome):
	if get_tree().is_network_server():
		for i in range(Numero_Jogadores):
			rpc_id(id, "Registrar_Jogador", Jogadores[i][0], Jogadores[i][1])
		rpc("Registrar_Jogador", id, novonome)
		Jogadores.aapend([])
		Jogadores[Numero_Jogadores].append([])
		Jogadores[Numero_Jogadores][0] = id
		Jogadores.aapend([])
		Jogadores[Numero_Jogadores].append([])
		Jogadores[Numero_Jogadores][1] = novonome
		Numero_Jogadores += 1
		Menu.Atuailizar_Lista_Jogadores()
	pass

func Remover_Jogador(posicao):
	Jogadores.remove(posicao)
	Numero_Jogadores -= 1
	Menu.Atuailizar_Lista_Jogadores()
	pass
	
func Mudar_Nome(novonome):
	Nome = novonome
	pass
	
func Mudar_Ip(novoip):
	Ip = novoip
	pass
	
func Pegar_Lista_Jogadores():
	return Jogadores
	pass
	
func Pegar_Numero_Jogadores():
	return Numero_Jogadores
	pass
	
func Pegar_Identificador():
	return Id
	pass

func Criar():
	Peer = ENetMultiplayerPeer.new()
	Peer.create_server()
	get_tree().set_network_peer(Peer)
	Peer.connect_to_node(self, "peer_disconnected", "disconectado_do_servidor")
	Id = get_tree().get_network_unique_id()
	
	Registrar_Jogador(Id, Nome)
	pass
	
func Entrar():
	Peer = ENetMultiplayerPeer.new()
	Peer.create_client()
	get_tree().set_network_peer(Peer)
	Id = get_tree().get_network_unique_id()
	pass
