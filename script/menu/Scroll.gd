extends ScrollContainer

@export var top_label : Node = null
@export var child_names : Array = []
@export var Horizontal : bool = false
@export var scroll_time_normal : float = 1.0
@export var scroll_time_first_to_last : float = 1.0
@export var transition_mode : Tween.TransitionType = Tween.TRANS_EXPO
@export var ease_mode : Tween.EaseType = Tween.EASE_OUT
@export var wait_needed : bool = true

signal child_changed
signal child_change_started

var tween : Tween
var child_positions : Array
var child_count : int
var child_current : int = 0
var child_size : int
var child_positions_difference_eighth : int
var scroll_rect : Rect2
var scroll_current : int
var scroll_lock : bool = false
var scroll_axis : String = "scroll_horizontal"
var selectedaxis : int
var otheraxis : int

func _ready() -> void:
	if wait_needed:
		await get_tree().process_frame # Wait scene to load.
	if top_label:
		top_label.text = ""
	# Configure axis selection
	selectedaxis = int(!Horizontal)
	otheraxis = int(Horizontal)
	# Select tween axis for tween property call
	scroll_axis = "scroll_horizontal" if Horizontal else "scroll_vertical"
	# Disable scroll bar visibility
	horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
	# Get rect size
	scroll_rect = get_rect()
	# Get child positions and save it in a array
	var child = get_child(0)
	if Horizontal:
		child_size = child.get_child(1).position.x
	else:
		child_size = child.get_child(1).position.y
	for i in range(child.get_child_count()):
		child_positions.append(child_size*i)
	# Calculate biases
	if len(child_positions) > 1: # At least 2 childs must be used
		child_positions_difference_eighth =  (child_positions[1] - child_positions[0]) / 8
	child_count = child.get_child_count() - 1

func _input(event):
	if Horizontal:
		#print(event,scroll_axis)
		pass

	if not scroll_lock and (event is InputEventScreenDrag or event is InputEventMouseMotion):
		if scroll_rect.has_point(event.position):
			var event_movement : int = event.relative[selectedaxis] if abs(event.relative[selectedaxis]) > min(10,3*abs(event.relative[otheraxis])) else 0
			scroll_current -= event_movement
			if abs(scroll_current) > child_positions_difference_eighth:
				end_scroll()
			get_tree().get_root().set_input_as_handled()
			return true

func end_scroll() -> void:
	if scroll_current < 0:
		child_current = child_current - 1 if child_current > 0 else child_count
	elif scroll_current > 0:
		child_current = child_current + 1 if child_current < child_count else 0
	scrollToChild(child_current)

func scrollToChild(idx : int) -> void:
	emit_signal("child_change_started")
	child_current = idx
	scroll_lock = true
	var scroll_select : int = child_positions[idx]
	if tween:
		tween.kill()
	tween = create_tween()
	if abs(scroll_select - get(scroll_axis)) > child_size:
		tween.tween_property(self,scroll_axis,scroll_select,scroll_time_first_to_last).set_ease(ease_mode).set_trans(transition_mode)
	else:
		tween.tween_property(self,scroll_axis,scroll_select,scroll_time_normal).set_ease(ease_mode).set_trans(transition_mode)
	if top_label:
		tween.parallel().tween_property(top_label,"theme_override_colors/font_color",Color.TRANSPARENT,0.1).set_delay(scroll_time_normal/4)
	tween.tween_callback(
		func lambda():
			scroll_lock = false;
			scroll_current = 0;
			tween.kill();
			top_label_text()
			emit_signal("child_changed");
			)

func top_label_text() -> void:
	if top_label:
		if tween:
			tween.kill()
		top_label.text = child_names[child_current]
		tween = create_tween()
		tween.tween_property(top_label,"theme_override_colors/font_color",Color.WHITE,0.05)

func get_current_child_idx() -> int:
	return child_current
