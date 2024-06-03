extends Node2D

var speed: int = 200
@export var damage = 10

@onready var ray1 = $Ray1
@onready var sprite1 = $Line1
@onready var ray2 = $Ray2
@onready var sprite2 = $Line2
@onready var ray3 = $Ray3
@onready var sprite3 = $Line3
@onready var ray4 = $Ray4
@onready var sprite4 = $Line4

# Called when the node enters the scene tree for the first time.
func _ready():
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray1.target_position += speed * Vector2.RIGHT * delta
	ray2.target_position += speed * Vector2.LEFT * delta
	ray3.target_position += speed * Vector2.UP * delta
	ray4.target_position += speed * Vector2.DOWN * delta
	sprite1.clear_points()
	sprite2.clear_points()
	sprite3.clear_points()
	sprite4.clear_points()
	sprite1.add_point(Vector2(0,0))
	sprite2.add_point(Vector2(0,0))
	sprite3.add_point(Vector2(0,0))
	sprite4.add_point(Vector2(0,0))
	sprite1.add_point(ray1.target_position)
	sprite2.add_point(ray2.target_position)
	sprite3.add_point(ray3.target_position)
	sprite4.add_point(ray4.target_position)



func _on_timeout():
	queue_free()  # Auto eliminar el nodo