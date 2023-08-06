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

@export var green_light : Node3D
@export var red_light : Node3D
@export var hazard_lights : Node3D
@export var wet_lights : Node3D

enum LIGHT {
    GREEN,
    RED,
    HAZARD,
    WET,
}

func turn_on_light(type : LIGHT, turn_on : bool):
    var node : Node3D
    match type:
        LIGHT.GREEN:
            node = green_light
        LIGHT.RED:
            node = red_light
        LIGHT.HAZARD:
            node = hazard_lights
        LIGHT.WET:
            node = wet_lights
    if node == null:
        return

    node.visible = turn_on
    return