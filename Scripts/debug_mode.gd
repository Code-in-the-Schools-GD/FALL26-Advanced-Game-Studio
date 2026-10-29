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
	var res_path: String
	res_path = DEBUG_RES_RES if OS.has_feature("editor") else DEBUG_USER_RES
	DirAccess.make_dir_recursive_absolute(res_path.trim_suffix("resource.tres"))
	if ResourceLoader.exists(res_path):
		debug_save = load(res_path) as DebugSave
	else:
		debug_save = DebugSave.new()
		ResourceSaver.save(debug_save, res_path)
	
	if debug_save != null:
		initial_debug_save()


func initial_debug_save() -> void:
	if not debug_save.debug_active: return
	
	match debug_save.skip_load:
		SkipLoad.NONE:
			pass
		SkipLoad.FADE_IN:
			get_tree().change_scene_to_file.call_deferred("res://Scenes/main_menu.tscn")
