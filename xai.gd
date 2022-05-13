extends AnimatedSprite


signal xaiMove(x, y)
var r = RandomNumberGenerator.new()
var sMemory = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var brain = File.new()
#	if not brain.file_exists("res://Xai\'sBrain/brain.txt"):
#		brain.open("res://Xai\'sBrain/brain.txt", File.WRITE)
#	brain.close()


func _toXai(grid, turn):
	#print(turn)
	var brain = File.new()
	var fileName = "res://Xai\'sBrain/" + str(turn) + "LMemory.txt"
	
	if not brain.file_exists(fileName): 
		brain.open(fileName, File.WRITE)
		brain.store_var([[grid,genResponces(grid)]],true)
		brain.close()
	getResponce(grid, turn)

func getResponce(grid, turn):
	var brain = File.new()
	var fileName = "res://Xai\'sBrain/" + str(turn) + "LMemory.txt"
	var loaded
	brain.open(fileName, File.READ)
	loaded = brain.get_var(true)
	#print(loaded)
	brain.close()
	var inMem = gridinLMemory(grid, loaded)
	if typeof(inMem) != 2:
		loaded.append([grid,genResponces(grid)])
		brain.open(fileName, File.WRITE)
		brain.store_var(loaded, true)
		brain.close()
		inMem = gridinLMemory(grid, loaded)
	
	var length = len(loaded[inMem][1])
	print(loaded[inMem])
	var tobeat
	while true:
		for i in range(length):
			#print("loops")
			if loaded[inMem][1][i][0] == 0:
				tobeat = 10000/1
			elif loaded[inMem][1][i][0] >= 10000:
				tobeat = 10000 - 9999
			else:
#				print(loaded[inMem][1][i][0])
				tobeat= 10000/loaded[inMem][1][i][0]
			r.randomize()
			var rand = r.randi_range(0, 10000)
			#print(rand, " ", tobeat)
			if rand > tobeat:
				sMemory.append([inMem,1,i])
				emit_signal("xaiMove", loaded[inMem][1][i][1], loaded[inMem][1][i][2])
				return

func gridinLMemory(grid, mem):
#	print(mem)
	for i in range(len(mem)):
		if mem[i][0] == grid:
			return i
	return false 
	
	
func genResponces(grid):
	var pResponce = []
	for x in range(len(grid)):
		for y in range(len(grid[x])):
			if grid[x][y] == "":
				pResponce.append([5000,x,y])
	return pResponce


func _winXai(tf):
	var lMemory = File.new()
#	var memHistory = File.new()
	var loaded
	#print(sMemory)
	for turn in range(len(sMemory)):
		#get brain
#		print(len(sMemory))
		#print(turn)
		var fileName = "res://Xai\'sBrain/" + str(turn) + "LMemory.txt"
		
		lMemory.open(fileName, File.READ)
		loaded = lMemory.get_var(true)
		
		lMemory.close()
#		var num = 0
#		#save history
#		while memHistory.file_exists("res://Xai\'sHistory/" + str(num) + "-" + str(turn) + "LMemory.txt" ):
#			num += 1
#		var historyFileName = "res://Xai\'sHistory/" + str(num) + "-" + str(turn) + "LMemory.txt"
#		memHistory.open(historyFileName, File.WRITE)
#		memHistory.store_var(loaded)
#		memHistory.close()
		#set memory for next game
		
#		print(fileName)
		
		if tf == 3:
			loaded[sMemory[turn][0]][sMemory[turn][1]][sMemory[turn][2]][0] += 2
		elif tf:
#			print(turn)
			loaded[sMemory[turn][0]][sMemory[turn][1]][sMemory[turn][2]][0] += 5
		elif loaded[sMemory[turn][0]][sMemory[turn][1]][sMemory[turn][2]][0] >= 0:
			loaded[sMemory[turn][0]][sMemory[turn][1]][sMemory[turn][2]][0] -= 5
			
		lMemory.open(fileName, File.WRITE)
		lMemory.store_var(loaded, true)
		lMemory.close()
	sMemory = []
