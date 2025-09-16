# NodeInput
 A Node-based Input Package for Godot
 

 Thought I would make this package seperate, since I often want the Node-based input solution from my main library without importing all the rest of it.
 

 This package contains a bunch of Nodes that allow you to construct input mappings in Godot in a scene, with Nodes and Signals, rather than using the clunky Input Map section of your project's Project Settings.
 

 ## How to use:
 
 1. Create an InputValue (Could be Bool, Float, or Vector. There are more values than this, but they are mainly used internally)
 2. Add an InputSource as a child of the InputValue. (Could be a button or axis from controller, mouse, or keyboard)
 3. Make sure the Value and Source's exports are set for your preferred button/axis from the selected input method.
 4. Use the InputValue's Signals or extend the InputValue. (Make sure you call InputValue's base "_ready" and "_physics_process" methods at the beginning of your own, or inputs will NOT update)
 5. Have fun!


## Interactions between Sources and Values


### Buttons/Keys

They will translate to a float or vector value from 0.0 to either 1.0 or -1.0, depending on how you set the Contribution variable.

For bools, they will behave as you would expect. True when pressed, False when released.

For floats, a contribution of Positive will result in 1.0 being added to the output, while Negative will result in -1.0 being added instead.

For Vectors, a contribution of any direction will result in adding 1.0x the direction's sign in Godot's Vector2 format


### Axis

For bools, they will output a true if the axis is past the Deadzone setting, and a false if it is within the Deadzone.

For floats, they will return their raw value, but values within the Deadzone will be rejected while values outside will be interpolated from 0.0 to 1.0 starting from the end of the Deadzone.

For Vectors, they will output their value like with floats, but contribution will choose whether the axis contributes to the X coordinate or Y coordinate of the Vector2.


### Axis2

For bools, they will output a true if the magnitude of the two axes' direction vector is past the Deadzone setting, and a false if it is within the Deadzone.

For floats, they will output the magnitude of the two axes' direction vector.

For Vectors, they will output the expected raw value, but deadzoned based on the Deadzone variable.


## Known Issues

Cursor sources are scuffed, I'll try to fix them eventually.
