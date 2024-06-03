extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("power_released", Callable(self, "_on_power_released"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_power_released(powers, paints):
	print("Powers recieved")
	for power in powers:
		if (power == "Poder 1"):
			print("Lanzando poder 1")
			var power_scene = load("res://powers/power_1.tscn")
			var power_node = power_scene.instantiate()
			add_child(power_node)
		elif (power == "Poder 2"):
			print("Lanzando poder 2")
			var power_scene = load("res://powers/power_2.tscn")
			var power_node = power_scene.instantiate()
			add_child(power_node)
		elif (power == "Poder 3"):
			print("Lanzando poder 3")
			var power_scene = load("res://powers/power_3.tscn")
			var power_node = power_scene.instantiate()
			add_child(power_node)
