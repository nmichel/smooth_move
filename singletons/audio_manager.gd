extends Node

var active_music_stream: AudioStreamPlayer

@export_group("Music")
@export var tracks: Node

func get_track_list() -> Array[String]:
	var all_tracks: Array[Node] = $Tracks.get_children()
	var names: Array = all_tracks.map(func(node: AudioStreamPlayer) -> String: return node.name)
	return Array(names, TYPE_STRING, "", null)

func play_track(track_name: String) -> void:
	active_music_stream = tracks.get_node(track_name)
	active_music_stream.play()
