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
		var pos = bunnies[i][0].get_pos()
		
		pos.x += bunnies[i][1].x * delta
		pos.y += bunnies[i][1].y * delta
	
		bunnies[i][1].y += grav * delta
	
		if pos.x > screen_size.x:
			bunnies[i][1].x *= -1
			pos.x = screen_size.x
		
		if pos.x < 0:
			bunnies[i][1].x *= -1
			pos.x = 0
			
		if pos.y > screen_size.y:
			pos.y = screen_size.y
			if randf() > 0.5:
				bunnies[i][1].y = -(randi() % 1100 + 50)
			else:
				bunnies[i][1].y *= -0.85
			
		if pos.y < 0:
			bunnies[i][1].y = 0
			pos.y = 0
		
		bunnies[i][0].set_pos(pos)

func add_bunny():
	var bunny = Sprite.new()
	bunny.set_texture(t_bunny)
	add_child(bunny)
	
	bunny.set_pos(Vector2(screen_size.x / 2, screen_size.y / 2))
	bunnies.append([bunny, Vector2(randi() % 200 + 50, randi() % 200 + 50)])

	get_node('gui/count').set_text('Bunny count: ' + str(bunnies.size()))

func remove_bunny():
	if bunnies.size() == 0: return
	bunnies[0][0].queue_free()
	bunnies.pop_front()
	get_node('gui/count').set_text('Bunny count: ' + str(bunnies.size()))
	
func plus(cnt):
	for i in range(cnt): add_bunny()

func minus(cnt):
	for i in range(cnt): remove_bunny()

func switch_to_texture():
	get_tree().change_scene('res://draw_texture.scn')

func switch_to_server():
	get_tree().change_scene('res://low_level_canvas.scn')