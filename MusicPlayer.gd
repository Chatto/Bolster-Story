extends Node
"""
	MusicPlayer Singleton Script
"""
const TRACKS: Dictionary = {
		"TRACK00" : preload("res://Music/Track00.ogg"),
		"TRACK01" : preload("res://Music/Track01.ogg"),
		"TRACK02" : preload("res://Music/Track02.ogg"),
		"TRACK03" : preload("res://Music/Track03.ogg"),
		"TRACK04" : preload("res://Music/Track04.ogg"),
		"TRACK05" : preload("res://Music/Track05.ogg"),
		"TRACK06" : preload("res://Music/Track06.ogg"),
		"TRACK07" : preload("res://Music/Track07.ogg"),
		"TRACK08" : preload("res://Music/Track08.ogg"),
		"TRACK09" : preload("res://Music/Track09.ogg"),
		}


var _streamplayer: AudioStreamPlayer = AudioStreamPlayer.new()


func _ready() -> void:
	_configure_player()
	
	# Default track
	play_track(TRACKS.TRACK07, -30.0)


func _configure_player() -> void:
	add_child(_streamplayer)
	_streamplayer.bus = "music"


func play_track(track_file: AudioStreamOGGVorbis, volume_db: float = -40.0) -> void:
	track_file.loop = true
	_streamplayer.stream = track_file
	_streamplayer.volume_db = volume_db
	
	_streamplayer.play(0.0)