class_name HUD
extends Control

enum GAUGE_TYPE {
	FRAME, # gauges that need to update every frame
	LAP, # gauges that need to update every lap
	SPECIAL, # gauges that should be updated with special signals
}

# ^"" -> NodePath Literal
@export var gauges : Dictionary = {
	GAUGE_TYPE.FRAME:{
		Car.STATE.THROTTLE:^"THROTTLE",
		Car.STATE.BRAKE:^"BRAKE",
		Car.STATE.CLUTCH:^"CLUTCH",
		Car.STATE.STEER:^"STEER",
		Car.STATE.ENGINE_RPM:^"ENGINE_RPM",
		Car.STATE.SPEED_MPS:^"SPEED_MPS",
	},
	GAUGE_TYPE.LAP:{
		Car.STATE.WHEEL_LIFE:^"WHEEL_LIFE",
	},
	GAUGE_TYPE.SPECIAL:{
		Car.STATE.GEAR:^"GEAR",
		Car.STATE.ABS:^"ABS",
		Car.STATE.OIL:^"OIL",
		Car.STATE.ENGINE:^"ENGINE",
		Car.STATE.WHEEL_TYPE:^"WHEEL_TYPE",
		Car.STATE.SPEED_UNIT:^"",
	},
}