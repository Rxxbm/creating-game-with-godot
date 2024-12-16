# SceneManager.gd
extends Node

var previous_scene : String = ""

# Função para armazenar a cena anterior
func store_previous_scene() -> void:
	previous_scene = get_tree().current_scene.filename

# Função para voltar à cena anterior
func go_back_to_previous_scene() -> void:
	if previous_scene != "":
		get_tree().change_scene_to_file(previous_scene)
	else:
		print("Nenhuma cena anterior armazenada.")
