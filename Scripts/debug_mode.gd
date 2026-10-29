class_name DebugModeController extends Node


const DEBUG_PREFS_FILE: String = "res://Debug/debug.dat"

enum SkipLoad {
	NONE,
	FADE_IN,
	MENU,
	TUTORIAL
}


class DebugSave extends Resource:
	
	@export var skip_load: SkipLoad
	
	
	func get_as_dict() -> Dictionary[String, Variant]:
		return {
			"skip_load": skip_load
		}
	
	
	func serialize_data(data: Dictionary) -> String:
		return JSON.stringify(data) #maybe more to do here later
	
	
	func save_prefs() -> void:
		var file := FileAccess.open(DEBUG_PREFS_FILE, FileAccess.WRITE)
		file.store_string(serialize_data(get_as_dict()))
	
	
	func load_prefs() -> void:
		var file := FileAccess.open(DEBUG_PREFS_FILE, FileAccess.READ)
		load_data(JSON.parse_string(file.get_as_text()))
	
	
	func load_data(data: Dictionary) -> void:
		for key in data:
			assert(key in self, "[DM] Invalid debug preference key")
			set(key, data[key])
