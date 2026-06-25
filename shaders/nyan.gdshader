shader_type canvas_item;

#include "cs_lib/cs_border.gdshaderinc"
#include "cs_lib/cs_color.gdshaderinc"
#include "cs_lib/cs_vector.gdshaderinc"

const float speed = 4.;

const float strenght = .02;

float to_center(vec2 v) {
	return length(v - vec2(.5));
}

void vertex() {
	VERTEX.x += strenght * sin(TIME * speed) * to_center(VERTEX.xy);
	VERTEX.y += strenght * sin(TIME * speed * .7) * to_center(VERTEX.xy);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
