extends Control

func _ready():
	print_debug("Main Menu ready")

func _on_start_new_pressed():
	SceneManager.LoadLevel("res://Scenes/Flat Plane.tscn")
	SceneManager.LoadLevel("res://Scenes/InGameUI.tscn")
	SceneManager.UnloadLevel($"..")


func _on_option_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	printerr("!QUIT WAS PRESSED, CLOSING PROGRAM!")
	get_tree().quit()
	print_debug("Goodbye!")
