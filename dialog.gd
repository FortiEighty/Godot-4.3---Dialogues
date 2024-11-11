extends Panel

# Loading a text object
@onready var main_text = $RichTextLabel

# Variables for typewriting effect
var isLineAppearing = false # To check if any text left
var total_characters # Amount of characters in text 
var text_speed = 1 # Amount of characters added to visibility per frame


func set_dialog(text):
	visible = true
	main_text.text = text
	
	# Setting typewriter values
	total_characters = main_text.text.length() # Getting length of the current text
	main_text.visible_characters = 0 # Setting visible characters to 0
	isLineAppearing = true # Starting the text appearance sequence

func _process(delta: float) -> void:
	if isLineAppearing == true:
		# If there are characters to show left
		if main_text.visible_characters < total_characters:
			# Adding 1 per frame
			main_text.visible_characters += text_speed
		else:
			isLineAppearing = false
	
