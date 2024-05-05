extends Control

@export var PauseOpen:bool = false
@onready var MOpenSound = $OpenMenuSound
@onready var PauseMenu = $Pause

func _input(event):
	if event.is_action_pressed("Pause"):
		print_debug("Pause was pressed")
		PauseOpen = !PauseOpen
		MouseLock(!PauseOpen)
		PauseMenu.visible = PauseOpen
		MOpenSound.play()
	

func MouseLock(LockState: bool):
	if LockState == true:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: if LockState == false:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_quit_pressed():
	SceneManager.UnloadAll()
	SceneManager.LoadLevel("res://Scenes/MainMenu.tscn")


func _on_option_pressed():
	pass # Replace with function body.


func _on_resume_pressed():
	PauseOpen = !PauseOpen
	MouseLock(!PauseOpen)
	PauseMenu.visible = PauseOpen
