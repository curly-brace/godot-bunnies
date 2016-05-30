# godot-bunnies
###Godot Engine bunny mark

#####there are three interchangable levels:
* first uses VisualServer's canvas items for low-level drawing
* second uses draw_texture to paint directly on screen (on node2d actually)
* third uses sprite nodes

there is a single script that handles all the stuff and convenient buttons to add and remove bunnies

#####test results in i5 2320, hd graphics 2000 (max for 20 fps)
* linux native: visualserver and sprites 5500 - bunnies. draw_texture - 2500 bunnies
* html5 chrome: sprites - 900 bunnies.visualserver - 800 bunnies. draw_texture - 500 bunnies
* html5 firefox: visualserver - 500 bunnies. sprites - 400 bunnies. draw_texture - 300 bunnies

![screenshot](/screenshot.png?raw=true)
