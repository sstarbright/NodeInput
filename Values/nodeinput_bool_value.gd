class_name InputBool
extends InputValue
## An input value node that outputs a boolean.

signal on_down()
signal on_up()
signal input_updated(value : bool)

var down = false
var up = false
var ignore_next_frame = false

func _ready():
	add_source_children(get_children())
	for source in sources:
		source.bool()
		current = source.current
		if current:
			break

func add_source_children(children : Array[Node]):
	for child in children:
		if child is InputSource:
			sources.append(child)
			child.start(self)
		else:
			add_source_children(child.get_children())

func _physics_process(delta):
	super._physics_process(delta)
	down = false
	up = false
	for source in sources:
		source.bool()
		if (source.changed):
			current = source.current
			changed = true
			down = source.down
			up = source.up
			
			if down && !ignore_next_frame:
				do_down()
			elif up && !ignore_next_frame:
				do_up()
			break
	ignore_next_frame = false
	input_updated.emit(current)

func do_down():
	on_down.emit()

func do_up():
	on_up.emit()

func enable():
	ignore_next_frame = true
	super.enable()
