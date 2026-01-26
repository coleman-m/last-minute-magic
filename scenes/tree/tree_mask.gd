extends Area2D

const bmp_path : String = "res://scenes/common/assets/20260110_last_minute_magic_christmas_tree_bitmap.bmp"
var bmp : BitMap = BitMap.new()

func _ready() -> void:
	#var bmp_img : Image = Image.new()
	#bmp_img.load_from_file(bmp_path)
	bmp = load(bmp_path)
	#bmp.create_from_image_alpha(bmp_img)
	var polygons = bmp.opaque_to_polygons(Rect2(Vector2.ZERO, bmp.get_size()), 1.0)
	for poly in polygons:
		var collision_poly = CollisionPolygon2D.new()
		collision_poly.polygon = poly
		self.add_child(collision_poly)
