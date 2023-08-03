class_name Track
extends StaticBody3D

@export var track_name : String = "Unnamed Track"

@export var reward_times : Array[int]= [
    1,
    2,
    3,
]

enum REWARD {
    GOLD,
    SILVER,
    BRONZE,
}

enum STATE {
    BEST_LAP,
    LAST_LAP,

    PENALTY,
}

@export var SECTOR_1 : Node
@export var SECTOR_2 : Node
@export var SECTOR_3 : Node

@export var GRID_POSITIONS : Array[Marker3D] = [
    null,
    null,
    null,
    null,
    null,
    null,
]

@export var RACING_LINE : Path3D