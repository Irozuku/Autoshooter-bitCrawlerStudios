extends Area2D

var speed: int = 250

var BASE_DAMAGE = 10

@export var damage = BASE_DAMAGE

var colors

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
	if 0 in colors:
		damage += int(damage*0.1)
	var timer = Timer.new()
	timer.wait_time = 2.5
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
	check_collision(ray1)
	check_collision(ray2)
	check_collision(ray3)
	check_collision(ray4)

func check_collision(ray):
	if ray.is_colliding():
		var col_int = ray.get_collision_count()
		for i in col_int:
			print("Rayo ha colisionado")
			var collider = ray.get_collider(i)
			SignalManager.power1(collider, damage)
			if 2 in colors:
				SignalManager.lifesteal(int(damage*0.1))

func assing_colors(paints):
	colors = paints

func _on_timeout():
	colors.clear()
	damage = BASE_DAMAGE
	queue_free()  # Auto eliminar el nodo
