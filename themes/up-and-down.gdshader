shader_type canvas_item;

void vertex() {
	VERTEX.y += sin(TIME*3.0)*4.0;
}

void fragment() {
	if (COLOR.a > 0.0) {
		COLOR = vec4(0.424, 0.306, 0.208, COLOR.a);
	}
}