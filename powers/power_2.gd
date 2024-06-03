extends "res://overlap/Hitbox.gd"

@onready var ColPolygon = $Hitbox/CollisionPolygon2D
@onready var sprite = $Sprite2D

var speed: float = 400
var sprite_speed: float = 5.0
var radio_inicial: float = 20.0
var radio_actual: float

# Called when the node enters the scene tree for the first time.
func _ready():
	# Crear un temporizador para eliminar el nodo después de 2 segundos
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))
	timer.start()
	radio_actual = radio_inicial
	_update_collision_polygon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	radio_actual += speed * delta
	_update_collision_polygon()
	_update_sprite(delta)

func _update_collision_polygon():
	var points = []
	var num_segments = 64
	for i in range(num_segments):
		var angle = i * PI * 2 / num_segments
		points.append(Vector2(cos(angle), sin(angle)) * (radio_actual/2))
	ColPolygon.polygon = PackedVector2Array(points)

func _update_sprite(delta):
	sprite.scale += Vector2(sprite_speed, sprite_speed) * delta

func _on_timeout():
	queue_free()  # Auto eliminar el nodo
