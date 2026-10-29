class_name DebugModeController extends Node


const DEBUG_PREFS_FILE: String = "res://Debug/debug.dat"
const DEBUG_RES_RES: String = "res://Debug/resource.tres"
const DEBUG_USER_RES: String = "user://Data/Debug/resource.tres"

enum SkipLoad {
	NONE,
	FADE_IN,
	MENU,
	TUTORIAL
}

var debug_save: DebugSave = null


func _ready() -> void:
	#if OS.is
	DirAccess.make_dir_recursive_absolute(DEBUG_USER_RES.trim_suffix("resource.tres"))
	if ResourceLoader.exists(DEBUG_USER_RES):
		debug_save = load(DEBUG_USER_RES) as DebugSave
	else:
		debug_save = DebugSave.new()
		ResourceSaver.save(debug_save, DEBUG_USER_RES)
	
	
	match debug_save.skip_load:
		SkipLoad.NONE:
			pass
		SkipLoad.FADE_IN:
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


class DebugSave extends Resource:
	
	@export var debug_active: bool = false
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
