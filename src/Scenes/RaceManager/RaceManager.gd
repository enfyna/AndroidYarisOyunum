class_name RaceManager
extends Node

enum MODE {
	RACING,
	TIME_TRIAL,
	TEST_DRIVE,
	#DRIFTING, # maybe later
}

@export var track : Node
