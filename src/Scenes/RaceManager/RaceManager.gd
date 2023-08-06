class_name RaceManager
extends Node

signal counting_down(left_count)
signal race_started

enum MODE {
	RACING,
	TIME_TRIAL,
	TEST_DRIVE,
	#DRIFTING, # maybe later
}

var track : Track
var cars : Array[CAR_STATE]

enum CAR_POSITION_STATE { # car is between ...
	C3_C1, # ... Control line 2 and start line
	C1_C2, # ... Start line and Control line 1
	C2_C3, # ... Control line 1 and control line 2
}

enum TRACK_SECTOR {
	SECTOR_1,
	SECTOR_2,
	SECTOR_3,
}

class CAR_STATE:
	var track_position : RaceManager.CAR_POSITION_STATE
	var current_lap : int

func add_car(car : Car):
	var car_state = CAR_STATE.new()
	car_state.track_position = CAR_POSITION_STATE.C3_C1
	car_state.current_lap = 0
	cars.append(car_state)

	car.race_man = self
	car.id = len(cars) - 1

	car.tree_entered.connect(func():car.global_transform = track.GRID_POSITIONS[car.id].global_transform)

	add_child(car)
	pass

func add_track(new_track : Track):
	track = new_track

	track.turn_on_light(Track.LIGHT.GREEN, false)
	track.turn_on_light(Track.LIGHT.HAZARD, false)
	track.turn_on_light(Track.LIGHT.WET, false)

	track.turn_on_light(Track.LIGHT.RED, true)

	bind_track_lines()

	add_child(track)
	pass

func bind_track_lines():
	var idx = 0
	for line in [track.SECTOR_1,track.SECTOR_2,track.SECTOR_3]:
		if line == null:
			print("No line added for : ",idx)
			continue
		line.body_entered.connect(track_line_passed.bind(idx))
		idx += 1
		pass
	pass

func track_line_passed(body: Node3D, line_id : TRACK_SECTOR):
	if not body is Car:
		return

	var car : Car = body
	var car_state : CAR_STATE = cars[car.id]

	match car_state.track_position:
		CAR_POSITION_STATE.C3_C1:
			if line_id == TRACK_SECTOR.SECTOR_1:
				car_state.track_position = CAR_POSITION_STATE.C1_C2
				car_state.current_lap += 1
				car.emit_signal("started_lap")
				return
			else:
				# give penalty
				# add this later
				return
		CAR_POSITION_STATE.C1_C2:
			if line_id == TRACK_SECTOR.SECTOR_2:
				car_state.track_position = CAR_POSITION_STATE.C2_C3
				return
			else:
				# give penalty
				# add this later
				return
		CAR_POSITION_STATE.C2_C3:
			if line_id == TRACK_SECTOR.SECTOR_3:
				car_state.track_position = CAR_POSITION_STATE.C3_C1
				return
			else:
				# give penalty
				# add this later
				return


@export var countdown_left : int = 3
func countdown():
	if countdown_left == 0:
		emit_signal("counting_down",countdown_left)
		emit_signal("race_started")
		track.turn_on_light(Track.LIGHT.RED, false)
		track.turn_on_light(Track.LIGHT.GREEN, true)
	else:
		emit_signal("counting_down",countdown_left)
		countdown_left -= 1

		await get_tree().create_timer(1).timeout
		countdown()
