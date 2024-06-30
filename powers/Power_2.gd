extends "res://overlap/Hitbox.gd"

@onready var ColPolygon = $CollisionShape2D
@onready var sprite = $Sprite2D

var BASE_DAMAGE = 10

var colors

var speed: float = 400
var sprite_speed: float = 5.0
var radio_inicial: float = 20.0
var radio_actual: float

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = BASE_DAMAGE
	if 0 in colors:
		damage += int(damage*0.1)
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()

func _on_area_entered(area):
	if 2 in colors:
		SignalManager.lifesteal(int(damage*0.1))

func assing_colors(paints):
	colors = paints

func _on_timeout():
	colors.clear()
	damage = BASE_DAMAGE
	queue_free()  # Auto eliminar el nodo