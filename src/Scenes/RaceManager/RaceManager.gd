class_name RaceManager
extends Node

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

	car.id = len(cars) - 1

	add_child(car)
	pass

func add_track(new_track : Track):
	track = new_track

	bind_track_lines()

	add_child(new_track)
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
				car.emit_signal("completed_lap")
				car_state.track_position = CAR_POSITION_STATE.C1_C2
				car_state.current_lap += 1
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
