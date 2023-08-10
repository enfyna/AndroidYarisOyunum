class_name ItemDB

const CarScenePath : Dictionary = {
    "AE86" : "res://src/Cars/AE86/AE86.tscn",
}

const TrackScenePath : Dictionary = {
    "TestTrack" : "res://src/Tracks/Test/Test01.tscn",
}

const Items : Dictionary = {
    0:{
        "id":0,
        "name":"Economy Tyres",
        "value":500,
        "type":"Wheel",
        "compound":Car.WHEEL_COMPOUNDS.ECONOMY,
        "description":"Cheapest tyre money can buy.",
    }
}

const Cars : Dictionary = {
    0:{
        "id":0,
        "name":"AE86",
        "value":50000,
        "type":"S",
        "description":"1980s era Japanese iconic car.",
        "scene_path":CarScenePath["AE86"],
    }
}

const Tracks : Dictionary = {
    0:{
        "id":0,
        "name":"Test Track",
        "value":10000,
        "type":"Testing",
        "description":"A track to test top speed of a low powered car.",
        "scene_path":TrackScenePath["TestTrack"],
    }
}

func getItem(ItemID : int) -> Dictionary:
    return Items.get(ItemID)

func getCar(CarID : int) -> Dictionary:
    return Cars.get(CarID)

func getTrack(TrackID : int) -> Dictionary:
    return Tracks.get(TrackID)
