extends Node2D

export(Texture) var t_bunny

var bunnies = []
var grav = 500
var screen_size
var elapsed = 0

func _ready():
	screen_size = get_viewport_rect().size
	
	for i in range(10): add_bunny()
	
	set_process(true)

func _process(delta):
	elapsed = elapsed + delta
	screen_size = get_viewport_rect().size
	
	if elapsed > 1:
		get_node('gui/fps').set_text('FPS: ' + str(OS.get_frames_per_second()))
		
		elapsed = 0
		
	for i in range(bunnies.size()):
		var pos = bunnies[i][1].o

		pos.x += bunnies[i][2].x * delta
		pos.y += bunnies[i][2].y * delta
	
		bunnies[i][2].y += grav * delta
	
		if pos.x > screen_size.x:
			bunnies[i][2].x *= -1
			pos.x = screen_size.x
		
		if pos.x < 0:
			bunnies[i][2].x *= -1
			pos.x = 0
			
		if pos.y > screen_size.y:
			pos.y = screen_size.y
			if randf() > 0.5:
				bunnies[i][2].y = -(randi() % 1100 + 50)
			else:
				bunnies[i][2].y *= -0.85
			
		if pos.y < 0:
			bunnies[i][2].y = 0
			pos.y = 0
		
		var new_pos = Matrix32()
		new_pos.o = pos
		VisualServer.canvas_item_set_transform(bunnies[i][0], new_pos)
		bunnies[i][1] = new_pos

func add_bunny():
	var bunny = VisualServer.canvas_item_create()

	var pos = Matrix32()
	pos.o = Vector2(screen_size.x / 2, screen_size.y / 2)
	VisualServer.canvas_item_set_transform(bunny, pos)
	
	var rect = Rect2(Vector2(), t_bunny.get_size())
	VisualServer.canvas_item_add_texture_rect(bunny, rect, t_bunny.get_rid(), false)
	
	VisualServer.canvas_item_set_parent(bunny, get_node("container").get_canvas_item())
	
	bunnies.append([bunny, pos, Vector2(randi() % 200 + 50, randi() % 200 + 50)])

	get_node('gui/count').set_text('Bunny count: ' + str(bunnies.size()))

func remove_bunnies():
	if bunnies.size() == 0: return
	
	#may be it will work someday
	#VisualServer.free(bunnies[0][0])

	get_node('gui/count').set_text('Bunny count: 0')

func plus(cnt):
	for i in range(cnt): add_bunny()

func switch_to_draw_texture():
	get_tree().change_scene('res://draw_texture.scn')
	
func switch_to_sprite():
	get_tree().change_scene('res://sprite.scn')