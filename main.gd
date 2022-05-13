extends Node2D

#Oai and Xai are twins. Xai is the brother and is older than his sister Oai.
#Ther father is crazy-Monkey they don't have a mother.
signal toOai(grid, turn)
signal toXai(grid, turn)
signal winXai(tf)
signal winOai(tf)
signal grid00(val)
signal grid01(val)
signal grid02(val)
signal grid10(val)
signal grid11(val)
signal grid12(val)
signal grid20(val)
signal grid21(val)
signal grid22(val)


var grid = [["","",""],["","",""],["","",""]]
var win
var turn
# Called when the node enters the scene tree for the first time.
func _ready():
#	var test = 0
#	var test2 = [[2,4],[2,3]]
#	for i in range(10):
#		print(i)
#
#	if typeof(test) == 1:
#		print('bool()')
	pass # Replace with function body.



#tests if there is a winner 
func winer():
	#print("testWinn")
	for i in range(len(grid)):
		if (grid[0][i] != "" and grid[0][i] == grid[1][i] and grid[0][i] == grid[2][i]):
			#print("1Winn")
			return [true, grid[0][i]]

		elif (grid[i][0] != "" and grid[i][0] == grid[i][1] and grid[i][0] == grid[i][2]):
			#print("2Winn")
			return [true, grid[i][0]]

	if (grid[0][0] != "" and grid[0][0] == grid[1][1] and grid[0][0] == grid[2][2]) :
		#print("3Winn")
		return [true, grid[0][0]]

	elif (grid[0][2] != "" and grid[0][2] == grid[1][1] and grid[0][2] == grid[2][0]) :
		#print("4Winn",grid[0][2])
		
		return [true, grid[0][2]]
	elif not grid[1].has("") and not grid[0].has("") and not grid[2].has(""):
		return [true, "cat's game"]
	
	else:
		return [false, ""]
		


func _StartBT():
	grid = [["","",""],["","",""],["","",""]]
	turn = 0
	win = winer()
	while not win[0]:
		#print(turn, grid)
		if not turn % 2:
			#print("Xai's turn")
			emit_signal("toXai", grid, int(turn/2))
		else:
			#print("Oai's turn")
			emit_signal("toOai", grid, int(turn/2))
		win = winer()
		turn += 1
	if win[1] == "X":
		print("x wins")
		for x in grid:
			print(x)
		emit_signal("winXai", 1)
		emit_signal("winOai", 0)
	elif win[1] == "O":
		print("o wins", win)
		for x in grid:
			print(x)
		emit_signal("winXai", 0)
		emit_signal("winOai", 1)
	else:
		print("cat's game")
		for x in grid:
			print(x)
		emit_signal("winXai", 3)
		emit_signal("winOai", 3)
	turn = 0 
	#_StartBT()
	
func _StartBTvsX():
	grid = [["","",""],["","",""],["","",""]]
	turn = 0
	win = winer()
	while not win[0]:
		#print(turn, grid)
		if not turn % 2:
			#print("Xai's turn")
			emit_signal("toXai", grid, int(turn/2))
		else:
			#print("Oai's turn")
			emit_signal("toOai", grid, int(turn/2))
		win = winer()
		turn += 1
	if win[1] == "X":
		print("x wins")
		for x in grid:
			print(x)
		emit_signal("winXai", 1)
		emit_signal("winOai", 0)
	elif win[1] == "O":
		print("o wins", win)
		for x in grid:
			print(x)
		emit_signal("winXai", 0)
		emit_signal("winOai", 1)
	else:
		print("cat's game")
		for x in grid:
			print(x)
		emit_signal("winXai", 3)
		emit_signal("winOai", 3)
	turn = 0 
	#_StartBT()
	
func _StartBTvsO():
	grid = [["","",""],["","",""],["","",""]]
	turn = 0
	win = winer()
	while not win[0]:
		#print(turn, grid)
		if not turn % 2:
			#print("Xai's turn")
			emit_signal("toXai", grid, int(turn/2))
		else:
			#print("Oai's turn")
			emit_signal("toOai", grid, int(turn/2))
		win = winer()
		turn += 1
	if win[1] == "X":
		print("x wins")
		for x in grid:
			print(x)
		emit_signal("winXai", 1)
		emit_signal("winOai", 0)
	elif win[1] == "O":
		print("o wins", win)
		for x in grid:
			print(x)
		emit_signal("winXai", 0)
		emit_signal("winOai", 1)
	else:
		print("cat's game")
		for x in grid:
			print(x)
		emit_signal("winXai", 3)
		emit_signal("winOai", 3)
	turn = 0 
	#_StartBTvsO()


func updateGrid(x,y, val):
	#print("grid"+str(x)+str(y),val)
	emit_signal("grid"+str(x)+str(y), val)
	
func _xaiMove(x, y):
	grid[x][y] = "X"
	updateGrid(x,y, "X")
	
	#print(grid, " X")
	

func _oaiMove(x, y):
	grid[x][y] = "O"
	updateGrid(x,y, "O")
	#print(grid, " O")


#func _on_LineEdit_text_changed(new_text):
	#pass # Replace with function body.


func _new_input(nodeName, value):
	print(nodeName, value)
	var x = int(str(nodeName[0]))
	var y = int(str(nodeName[1]))
	grid[x][y] = "X"
	if not win[0]:
		print(grid)
#		if not turn % 2:
#			#print("Xai's turn")
#			#emit_signal("toXai", grid, int(turn/2))
#			pass
#		else:
			#print("Oai's turn")
		emit_signal("toOai", grid, int(turn/2))
		win = winer()
		turn += 1
	if not win[0]:
		pass
	elif win[1] == "X":
		print("you win")
		for xg in grid:
			print(x)
		emit_signal("winXai", 1)
		emit_signal("winOai", 0)
	elif win[1] == "O":
		print("o wins", win)
		for xg in grid:
			print(x)
		emit_signal("winXai", 0)
		emit_signal("winOai", 1)
	else:
		print("cat's game")
		for xg in grid:
			print(x)
		emit_signal("winXai", 3)
		emit_signal("winOai", 3)


func playerVsOai():
	grid = [["","",""],["","",""],["","",""]]
	turn = 0
	win = winer()
	
