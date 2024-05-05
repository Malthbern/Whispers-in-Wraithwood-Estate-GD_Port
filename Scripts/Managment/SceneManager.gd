extends Node

var ScenesLoaded:int = 1

func LoadLevel(Level: String):
	print_debug("Loading level at " + Level)
	var loading = load(Level)
	var loaded = loading.instantiate()
	get_tree().root.add_child(loaded)
	ScenesLoaded += 1

func UnloadLevel(Level: Node):
	print_debug("Unloading level at " + Level.name)
	get_tree().root.remove_child(Level)
	Level.queue_free()
	ScenesLoaded -= 1

func UnloadAll():
	while ScenesLoaded > 0:
		var _N
		_N = get_tree().root.get_child(ScenesLoaded + 1)
		print_debug("Unloading level at " + _N.name)
		get_tree().root.remove_child(_N)
		_N.queue_free()
		ScenesLoaded -= 1
