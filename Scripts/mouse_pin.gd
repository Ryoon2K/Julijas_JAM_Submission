extends Node2D


@onready var mouse_pin: DampedSpringJoint2D = $MousePin
@onready var fake_body: StaticBody2D = $MousePin/FakeBody
@onready var soft_body_2d: SoftBody2D = $SoftBody2D


var is_dragging = false
var picked_bone: RigidBody2D


func _ready() -> void:
	# Set the node_a to a static body without a collision, we only need it for the pin effect.
	mouse_pin.node_a = mouse_pin.get_path_to(fake_body)
	# Connect the input_event signal to its function
	for bone in soft_body_2d.get_rigid_bodies():
		bone.rigidbody.input_pickable = true
		bone.rigidbody.input_event.connect(_on_input_event.bind(bone.rigidbody))


func _physics_process(delta: float) -> void:
	mouse_pin.global_position = get_global_mouse_position()


func _unhandled_input(event: InputEvent) -> void:
	# If we are dragging and the user releases the mouse button then
	if is_dragging and event is InputEventMouseButton and not event.is_pressed():
		# Clear the node_b path
		mouse_pin.node_b = NodePath()
		is_dragging = false
		# Reset the angular damp to 0
		picked_bone.angular_damp = 0
		# Or unlock the rotation of the rigid body with
#		rigid_body_2d.lock_rotation = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int, bone: RigidBody2D) -> void:
	# If we aren't dragging and a mouse button press happens then
	if not is_dragging and event is InputEventMouseButton and event.is_pressed():
		# Set the node_b to the rigid body that triggered this input event
		mouse_pin.node_b = mouse_pin.get_path_to(bone)
		is_dragging = true
		picked_bone = bone
		# Up the angular damp to avoid rotating like crazy when moving the mouse
		bone.angular_damp = 10
		# You can also lock the rotation of the rigid body with
#		rigid_body_2d.lock_rotation = true
