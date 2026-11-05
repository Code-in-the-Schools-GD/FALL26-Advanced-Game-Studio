class_name Player extends CombatCharacter


@export var speed = 300.0
@export var jump_force = -400.0
@export var gravity: bool = true


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("test_function_button"):
		testing_things_function()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and gravity:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
	elif gravity:
		velocity.y = jump_force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func take_damage(damage : int) -> void:
	if invulnerable:
		health -= damage
		print(damage,"taken",health,"Remaining")
	if health <= 0:
		die()


func attack(attack_damage: int) -> void:
	pass


func die(damage_source: DamageSource = null) -> void:
	pass


func testing_things_function(): ## its a function for testing things test things with it
	take_damage(5)
