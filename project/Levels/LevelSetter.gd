extends Node2D

const LIGHT_BLOCK = 1
const DARK_BLOCK = 2
const PURE_DARK_BLOCK = 3
const FINISH_BLOCK = 4
const SPIKE_BLOCK = 5
const PATH_BLOCKS_SCENES_RESOURCES = "res://Scenes/Blocks/"
const PATH_FINISH_SCENE_RESOURCE = "res://Scenes/FinishLine/"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (String) var nextLevelPath
export (PackedScene) var streamPlayer

onready var light_only = load("res://Templates/onlyLight.tres")
func _ready():
	get_node("bg").set_use_parent_material(true)
	get_node("bg").set_modulate(Color ("797979"))
	get_node("darkbg").set_scale( Vector2( 100, 100) )
	get_node("TileMap").get_tileset().tile_set_material(0 , light_only )
	
	add_child(streamPlayer.instance())
	
	set_process(true)
	
	setBlocks()


onready var light_block_res = load(PATH_BLOCKS_SCENES_RESOURCES + "LightBlock.tscn")
onready var dark_block_res = load(PATH_BLOCKS_SCENES_RESOURCES + "DarknessBlock.tscn")
onready var finish_line_res = load(PATH_FINISH_SCENE_RESOURCE + "FinishLine.tscn")
onready var spike_block_res = load(PATH_BLOCKS_SCENES_RESOURCES + "Spike.tscn")

func setBlocks():
	for x in range( 0 , 100 ):
		for y in range( 0 , 100):
			var tile = get_node("TileMap").get_cell( x , y )
			if( tile > 0 ):
				get_node("TileMap").set_cell(x , y , -1 )
				var inst
				if( tile == LIGHT_BLOCK ):
					inst = light_block_res.instance()
				elif( tile == DARK_BLOCK ):
					inst = dark_block_res.instance()
				elif( tile == PURE_DARK_BLOCK ):
					inst = dark_block_res.instance()
					inst.appear = false
				elif( tile == FINISH_BLOCK ):
					inst = finish_line_res.instance()
				elif( tile == SPIKE_BLOCK ):
					inst = spike_block_res.instance()
				inst.set_pos( Vector2(16,16) + Vector2(x,y)*32 )
				add_child( inst )



func _process(delta):
	if( InputSingleton.wasKeyPressedNow("R") ):
		get_tree().reload_current_scene()









