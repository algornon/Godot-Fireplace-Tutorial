extends Node2D

@onready var fire: AnimatedSprite2D = $Fire
@onready var embers: CPUParticles2D = $Embers
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var point_light_2d: PointLight2D = $PointLight2D

var active = true

var light_target
var light_current
var light_max

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light_max = point_light_2d.energy
	light_current = light_max
	light_target = light_max

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if point_light_2d.energy != light_target:
		point_light_2d.energy = move_toward(point_light_2d.energy, light_target, delta)

func toggle() -> void:
	if active:
		turn_off()
	else:
		turn_on()
		
func turn_on() -> void:
	
	active = true
	
	# Animation
	fire.play("start")
	await fire.animation_finished
	fire.play("default")
	
	# Particles
	embers.emitting = true
	
	# Sound
	audio_stream_player_2d.play()
	
	# Lighting
	light_target = light_max
	
func turn_off() -> void:
	
	active = false
	
	# Animation
	fire.play("end")
	
	# Particles
	embers.emitting = false
	
	# Sound
	audio_stream_player_2d.stop()
	
	# Lighting
	light_target = 0
