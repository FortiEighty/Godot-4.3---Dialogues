extends CharacterBody2D

# Loading player on object spawn
@onready var mainPlayer = $"../Player"

# Loading interact marker
@onready var interactMarker = $Interact

# Storing current interactability state
var isInteractable = false # by default not interactable
var isInDialog = false # setting the state if player is already in dialog or not

# Loading dialog object
@onready var dialog_window = $"../CanvasLayer/Dialog"

# Dialog texts
var main_line = 'Hello, this is a test line for a dialogue.'

# Triggered when any other Area2D enters the area
func _on_area_2d_area_entered(area: Area2D) -> void:
	# Checking if entered area is player
	if area.get_parent() == mainPlayer:
		# If area is player showing marker and setting interactability to true
		interactMarker.visible = true
		isInteractable = true

# Triggered when any other Area2D exits the area
func _on_area_2d_area_exited(area: Area2D) -> void:
	# Checking if exited area is player
	if area.get_parent() == mainPlayer:
		# If area is player showing marker and setting interactability to false
		interactMarker.visible = false
		isInteractable = false
		# If dialog was opened
		if isInDialog == true:
			dialog_window.visible = false
			isInDialog = false

## Player who is located not too close enough to NPC won't be able to start dialogue.

# If player is close enough and NPC is interactable
# Turning on dialog on button 'F' pressed
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			# If player is close enough and not currently in dialog
			if isInteractable == true and isInDialog == false:
				# Starting dialog
				dialog_window.set_dialog(main_line)
				# Making impossible to start over dialog
				interactMarker.visible = false
				isInDialog = true
