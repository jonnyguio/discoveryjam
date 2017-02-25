extends Node2D

const LIGHT_BLOCK = 1
const DARK_BLOCK = 2


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var light_only = load("res://Templates/onlyLight.tres")
func _ready():
	get_node("bg").set_use_parent_material(true)
	get_node("TileMap").get_tileset().tile_set_material(0 , light_only )
	
	set_process(true)
	
	setBlocks()


onready var light_block_res = load("res://LightBlock.tscn")
onready var dark_block_res = load("res://DarknessBlock.tscn")

func setBlocks():
	for x in range( 0 , 100 ):
		for y in range( 0 , 100):
			var tile = get_node("TileMap").get_cell( x , y )
			if( tile == LIGHT_BLOCK or tile == DARK_BLOCK ):
				get_node("TileMap").set_cell(x , y , -1 )
				var inst
				if( tile == LIGHT_BLOCK ):
					inst = light_block_res.instance()
				elif( tile == DARK_BLOCK ):
					inst = dark_block_res.instance()
				inst.set_pos( Vector2(16,16) + Vector2(x,y)*32 )
				add_child( inst )



func _process(delta):
	if( InputSingleton.wasKeyPressedNow("R") ):
		get_tree().reload_current_scene()










