extends ColorRect
var Burger = 0 
var plural = "Burger"
var CookTime = 10
var CookBar = 100 / CookTime
var BPS = 0
var Money = 0
var Chef = 0
var ChefP = 100
var ChefA = 0
var ChefB = 1
var BCost = 2.50
var Cashier = 0
var CashierP = 100
var Customer = 0
var CustomRNG = RandomNumberGenerator.new()
var CustomC = 10
var CustomA = 0
var button 
var cProgress
onready var timer = get_node("T_Burger")
onready var CTimer = get_node("T_Customer")
onready var CookT = get_node("T_Cook")
onready var CookB = get_node("T_Bar")

func _ready():
	cProgress = get_node("ProgressBar")
	button = get_node("B_Cook")
	timer.set_wait_time(1)
	timer.start()
	CTimer.set_wait_time(15)
	CTimer.start()
	CookB.set_wait_time(1)
	button = get_node("B_Cook")
	print(Burger)
	get_node("man").visible = false
	get_node("Camera2D").current = true
	get_node("L_Customer").text = str(Customer) + " Customer/s"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Burger > 1:
		plural = "Burgers"
	else:
		plural = "Burger"
	ChefA = Chef * ChefB

func _on_B_Cook_pressed():
	CookT.set_wait_time(CookTime)
	CookT.start()
	CookB.start()
	button.set_disabled(true)


func _on_Burger_Timer():
	BPS = ChefA 
	Burger += BPS
	print(Burger)
	get_node("L_Burgers").text = str(Burger) + " " + plural
	get_node("L_Money").text = "$" + str(Money)
	get_node("L_Chef").text = str(Chef)
	get_node("L_Cashier").text = str(Cashier)
	get_node("L_Customer").text = str(Customer) + " Customer/s"


func _on_B_Chef_pressed():
	if Money >= ChefP:
		Chef += 1
		Money -= ChefP
		get_node("L_Chef").text = str(Chef)
		get_node("L_Money").text = str(Money)


func _on_B_Sell_pressed():
	if Burger > 0:
		if Customer > 0:
			Burger -= 1
			Customer -= 1
			Money += BCost
			get_node("L_Burgers").text = str(Burger) + " " + plural
			get_node("L_Money").text = "$" + str(Money)
			get_node("L_Chef").text = str(Chef)
			get_node("L_Customer").text = str(Customer) + " Customer/s"
			if Customer > 0:
				get_node("man").visible = true
			else:
				get_node("man").visible = false
			

func _on_B_Cashier_pressed():
	if Money >= CashierP:
		Cashier += 1
		Money -= CashierP
		get_node("L_Cashier").text = str(Cashier)
		get_node("L_Money").text = "$" + str(Money)


func _on_Customer_Timer():
	CustomRNG.randomize()
	CustomA == CustomRNG.randi_range(1,100)
	if CustomA <= CustomC:
		Customer += 1
		get_node("L_Customer").text = str(Customer) + " Customer/s"
	if Customer > 0:
		get_node("man").visible = true
	else:
		get_node("man").visible = false


func _on_T_Cook_timeout():
	Burger += 1
	get_node("L_Burgers").text = str(Burger) + " " + plural
	CookT.stop()


func _on_T_Bar_timeout():
	if cProgress.value < 100:
		cProgress.value += CookBar
	else:
		cProgress.value = 0
		CookB.stop()
		button.set_disabled(false)


func _on_B_Upgrades_pressed():
	get_node("Camera2D").current = false
	get_node("Camera2D2").current = true


func _on_B_Main_pressed():
	get_node("Camera2D").current = false
	get_node("Camera2D").current = true


func _on_B_upgrade_pressed():
	if Money >= 10:
		Money -= 10
		CustomC += 1
		get_node("B_Upgrade001").disabled = true
		get_node("B_Upgrade001").visible = false
