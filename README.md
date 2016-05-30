# godot-bunnies
###Godot Engine bunny mark

there are three interchangable levels

first uses VisualServer's canvas items for low-level drawing

second uses draw_texture to paint directly on screen (on node2d actually)

third uses sprite nodes

there is a single script that handles all the stuff and convenient buttons to add and remove bunnies

actually the difference in native build between theese methods is drastic (VisualServer wins, second place for Sprite nodes), but in html5 the difference is not very noticable (both are slow)

![screenshot](/screenshot.png?raw=true)
