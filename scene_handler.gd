extends Node

var main_menu = preload("res://Scenes/UIScene/main_menu.tscn")
var gamemode_select_scene = preload("res://Scenes/UIScene/GameModeSelect.tscn")
var level_select_scene = preload("res://Scenes/UIScene/LevelSelect.tscn")

func _ready():
	load_main_menu()
	
func load_main_menu():
	add_child(main_menu.instantiate())
	get_node("MainMenu/M/VB/NewGame").pressed.connect(on_play_pressed)
	get_node("MainMenu/M/VB/Quit").pressed.connect(on_quit_pressed)

	
func on_play_pressed():
	get_node("MainMenu").queue_free()
	load_gamemode_select_scene()
	
func on_quit_pressed():
	get_tree().quit()

func unload_game(result):
	$GameScene.queue_free()
	load_main_menu()
	
func load_gamemode_select_scene():
	call_deferred('add_child', gamemode_select_scene.instantiate())

func on_campaign_pressed():
	get_node("GameModeSelect").queue_free()
	load_level_select()
	
func on_endless_pressed():
	pass
	
func on_challenge_pressed():
	pass

func load_level_select():
	call_deferred('add_child', level_select_scene.instantiate())
	
func on_play_level_pressed():
	var level = $LevelSelect.level
	get_node("LevelSelect").queue_free()
	load_level(level)

func load_level(level):
	await(get_tree().create_timer(0.001)).timeout
	var game_scene = load("res://Scenes/MainScenes/Game_Scene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	call_deferred('add_child', game_scene, true)
	game_scene.level = level
