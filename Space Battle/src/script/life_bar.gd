extends ProgressBar

func change_color(color) -> void:
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(color)
	sb.set_corner_radius_all(9)
