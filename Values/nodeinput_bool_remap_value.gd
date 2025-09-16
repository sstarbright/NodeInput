class_name InputRemapBool
extends InputRemapValue

signal on_down()
signal on_up()

var down = false
var up = false
var ignore_next_frame = false

func _ready():
	super._ready()
	var children = get_children()
	for child in children:
		if child is InputSource:
			sources.append(child)
			child.start(self)
	for source in sources:
		source.bool()
		current = source.current
		if current:
			break

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

func do_down():
	on_down.emit()

func do_up():
	on_up.emit()

func enable():
	ignore_next_frame = true
	super.enable()
