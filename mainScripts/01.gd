extends LineEdit


var regex = RegEx.new()
var oldtext = ""
signal new_input(nodeName, value)

func _ready():
	regex.compile("^[X,O,o,x]*$")

func _on_LineEdit_text_changed(new_text):
	#makes sure iput value is int
	if regex.search(new_text):
		text = new_text   
		oldtext = text
		#sends new value and node name to solved
		emit_signal("new_input", get_name(), text)
	else:
		text = oldtext
	set_cursor_position(text.length())
	
func get_value():
	return(int(text))

func _grid01(val):
	text = val



func _on_StartBT_button_down():
	text = ""
