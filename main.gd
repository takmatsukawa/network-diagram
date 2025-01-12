extends Node2D

var node_scene = preload("res://node.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var graph_data = {
		"nodes": [
			{"id": "A", "position": Vector2(100, 200)},
			{"id": "B", "position": Vector2(400, 400)},
			{"id": "C", "position": Vector2(200, 800)},
		],
		"edges": [
			{"from": "A", "to": "B"},
			{"from": "B", "to": "C"},
		]
	}
	
	build_network(graph_data)

func build_network(graph_data):
	for node_data in graph_data["nodes"]:
		create_node(node_data["id"], node_data["position"])
	for edge_data in graph_data["edges"]:
		var from_node = find_node_by_id(graph_data, edge_data["from"])
		var to_node = find_node_by_id(graph_data, edge_data["to"])
		if from_node and to_node:
			create_edge(from_node.position, to_node.position)
			
func find_node_by_id(graph_data, id):
	for node_data in graph_data["nodes"]:
		if node_data["id"] == id:
			return node_data
	
	return null

func create_node(id, position):
	var node_instance = node_scene.instantiate()
	node_instance.position = position
	node_instance.id = id
	add_child(node_instance)

func create_edge(from_pos, to_pos):
	var line = Line2D.new()
	line.points = [from_pos, to_pos]
	line.default_color = Color(1, 1, 1)  # 白色
	add_child(line)
