tool
extends Node

export(Array, AudioStream) var streams = [] setget set_streams, get_streams
export(bool) var randomizePitch = false
export(float, 0, 10, .05) var pitchMininimum = .9
export(float, 0, 10, .05) var pitchMaximum = 1.1

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _get_configuration_warning():
	if streams == null && get_child_count() > 0:
		return "Stream array is out of sync with children. Children should be configured only through the streams property of %s." % name
	if get_child_count() != streams.size():
		return "Stream array is out of sync with children. Children should be configured only through the streams property of %s." % name
	for i in range(get_child_count()):
		var child = get_child(i)
		if child.stream != streams[i]:
			return "Node [{childName}] is out of sync with the streams array of {rootName}.".format({ "childName": child.name, "rootName": name })
	return ""

func play(): 
	var validChildren = []
	for child in get_children():
		if !child.playing:
			validChildren.append(child)
	
	if validChildren.size() == 0:
		return
	
	var randomIndex = rng.randi_range(0, validChildren.size() - 1)
	var child = validChildren[randomIndex] as AudioStreamPlayer
	if randomizePitch:
		child.pitch_scale = rng.randf_range(pitchMininimum, pitchMaximum)
	child.play()
	
func play_times(times: int):
	for i in range(times):
		play()

func remove_stream_player(node: AudioStreamPlayer):
	node.owner = null
	remove_child(node)
	node.queue_free()

func add_new_node(stream: AudioStream):
	var root = get_tree().edited_scene_root
	var newNode = AudioStreamPlayer.new()
	add_child(newNode)
	newNode.owner = root
	newNode.stream = stream

func update_stream_player_nodes():
	if !Engine.editor_hint:
		return

	var existingNodes = []
	for node in get_children():
		if (node.stream != null):
			existingNodes.append(node)
		remove_child(node)
		node.owner = null

	for i in range(streams.size()):
		var root = get_tree().edited_scene_root
		if (streams[i] != null):
			var existingNode = extract_first_node_with_stream(existingNodes, streams[i].resource_path)
			if existingNode != null:
				add_child(existingNode)
				existingNode.owner = root
				existingNode.name = "AudioStreamPlayer%s" % (existingNode.get_index() + 1)
			else:
				add_new_node(streams[i])
		else:
			add_new_node(null)

	for node in existingNodes:
		node.queue_free()

func extract_first_node_with_stream(existingNodes: Array, resourcePath: String) -> AudioStreamPlayer:
	var foundNode: AudioStreamPlayer = null
	for i in range(existingNodes.size()):
		var node = existingNodes[i]
		if (node.stream != null && node.stream.resource_path == resourcePath):
			foundNode = node
			existingNodes.remove(i)
			break
	return foundNode

func set_streams(num):
	streams = num
	update_stream_player_nodes()

func get_streams():
	return streams
