class_name Player extends CombatCharacter



## Speed of the Player
@export var speed = 300.0
## How high the Player jumps
@export var jump_force = -400.0
## The dash's cooldown
@export var dash_cooldown: float = 5.0
## The dash's speed
@export var dash_speed: float = 1500
## if the player can crouch or not
var can_crouch: bool = true
## if the player is crouching
var crouching: bool = false
## The Player is dashing or not
var dashing: bool = false
## Arena reference
var arena: Arena = null

## Melee hitbox of the Player
@onready var melee_attack_hitbox: Area2D = $MeleeAttack/Area2D
##
@onready var player_hitbox: CollisionShape2D = $CollisionShape2D
##
@onready var player_sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("test_function_button"):
		## The function to test things
		testing_things_function()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and experiences_gravity:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not dashing:
		velocity.y = jump_force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if dashing:
		velocity.y = 0
		velocity.x = direction * dash_speed
	elif direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed / 1.0 if is_on_floor() else 10.0)
 
## if the Player can dash or not
	var can_dash: bool = true
## If the Player pushes the dash button they dash
	if Input.is_action_just_pressed("Dash") and not dashing:
		if can_dash:
			can_dash = false
			dashing = true
			await get_tree().create_timer(0.175).timeout
			dashing = false
			can_dash = true


	# If the player pushes the crouch button they crouch
	if Input.is_action_just_pressed("crouch") and not dashing:
		if can_crouch:
			if not crouching:
				crouching = true
				player_sprite.scale = Vector2(0.32, 0.18)
				player_hitbox.shape.size = Vector2(38,25)
				print(crouching)
			elif crouching:
				crouching = false
				player_hitbox.shape.size = Vector2(38,50)
				player_sprite.scale = Vector2(0.32, 0.36)
				print("no more crouching")

	move_and_slide()


@warning_ignore("unused_parameter")
## Does the melee attack
func attack(melee_attack_damage: int, damage_source: DamageSource = null, take_offense := false) -> void:
	$MeleeAttack.execute()
	print("kaboom")


@warning_ignore("unused_parameter")
## kills the Player
func die(damage_source: DamageSource = null) -> void:
	pass


func fall_into_hazard(hazard: Hazard) -> void:
	health -= hazard.damage
	if health <= 0:
		die(hazard.damage_source)
	else:
		teleport_to_last_safe_position()


func testing_things_function(): ## its a function for testing things test things like functions with it
	attack(1)
