extends Node2D

@onready var mouse_pin: DampedSpringJoint2D = $MousePin
@onready var fake_body: StaticBody2D = $MousePin/FakeBody
@onready var soft_body_2d: SoftBody2D = $SoftBody2D

var is_dragging = false
var picked_bone: RigidBody2D
var isHoveredStack = [false]

func _ready() -> void:
	soft_body_2d.joint_removed.connect(_on_joint_removed)
	# Set the node_a to a static body without a collision, we only need it for the pin effect.
	mouse_pin.node_a = mouse_pin.get_path_to(fake_body)
	# Connect the input_event signal to its function
	for bone in soft_body_2d.get_rigid_bodies():
		bone.rigidbody.input_pickable = true
		bone.rigidbody.input_event.connect(_on_input_event.bind(bone.rigidbody))
		bone.rigidbody.mouse_entered.connect(_on_focus.bind(bone.rigidbody))
		bone.rigidbody.mouse_exited.connect(_on_blur)

func _physics_process(delta: float) -> void:
	mouse_pin.global_position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	# If we are dragging and the user releases the mouse button then
	if is_dragging and picked_bone != null and event is InputEventMouseButton and not event.is_pressed():
		# Clear the node_b path
		mouse_pin.node_b = NodePath()
		is_dragging = false
		if(isHoveredStack[0] == true):
			Input.set_default_cursor_shape(Input.CURSOR_MOVE)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		# Reset the angular damp to 0
		picked_bone.angular_damp = 0
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			picked_bone.lock_rotation = not picked_bone.lock_rotation
			picked_bone.freeze = not picked_bone.freeze
		picked_bone = null
		# Or unlock the rotation of the rigid body with
#		rigid_body_2d.lock_rotation = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int, bone: RigidBody2D) -> void:
	# If we aren't dragging and a mouse button press happens then
	if event is InputEventMouseButton and event.is_pressed():
		if not is_dragging and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			# Set the node_b to the rigid body that triggered this input event
			mouse_pin.node_b = mouse_pin.get_path_to(bone)
			is_dragging = true
			Input.set_default_cursor_shape(Input.CURSOR_DRAG)
			
			picked_bone = bone
			# Up the angular damp to avoid rotating like crazy when moving the mouse
			bone.angular_damp = 10
			# You can also lock the rotation of the rigid body with
	#		rigid_body_2d.lock_rotation = true
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			bone.lock_rotation = not bone.lock_rotation
			bone.freeze = not bone.freeze

func _on_focus( bone: RigidBody2D):
	isHoveredStack.push_front(true)
	if (!is_dragging):
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND if bone.freeze else Input.CURSOR_MOVE)

func _on_blur():
	if (isHoveredStack.size() > 1):
		isHoveredStack.pop_front()
	if (!is_dragging && isHoveredStack[0] == false):
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_joint_removed(rigid_body_a: SoftBody2D.SoftBodyChild, rigid_body_b: SoftBody2D.SoftBodyChild):
	# TODO: Show death screen
	soft_body_2d.break_distance_ratio = 0.1
