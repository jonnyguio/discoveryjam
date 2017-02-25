extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var light_only = load("res://Templates/onlyLight.tres")
func _ready():
	get_node("bg").set_use_parent_material(true)
	get_node("PushableBlock").set_use_parent_material(true)
	get_node("PushableBlock").get_node("Sprite").set_use_parent_material(true)
	get_node("Lightblocks").set_use_parent_material(true)
	get_node("TileMap").get_tileset().tile_set_material(0 , light_only )
	pass
