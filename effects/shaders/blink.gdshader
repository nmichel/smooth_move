shader_type canvas_item;
uniform vec4 blink_color: source_color;
uniform float blink_intensity = 0.5;

void fragment() {
	vec4 color = mix(COLOR, blink_color, blink_intensity * blink_color.a);
	COLOR = color;
}
